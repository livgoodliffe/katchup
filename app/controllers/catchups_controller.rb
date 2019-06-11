class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params.key?(:catchup_accept)
      puts 'ACCEPT MESSAGE DETECTED'
      @catchup = Catchup.find(params[:catchup_invitation_id])
      @action = "remove"
      puts "guest user id #{current_user.id} catchup_id #{@catchup.id}"

      guest = Guest.where(user_id: current_user.id).where(catchup_id: @catchup.id).first
      guest.accepted!

      notifications = Notification.where(user_id: current_user.id)
      notifications.each do |notification|
        content = JSON.parse(notification.content)
        if content["catchup_id"] == @catchup.id
          notification.update(dismissed: true)
        end
      end

      respond_to do |format|
        format.js
      end
    elsif params.key?(:catchup_decline)
      puts 'DECLINE MESSAGE DETECTED'
      @catchup = Catchup.find(params[:catchup_invitation_id])
      @action = "remove"

      guest = Guest.where(user_id: current_user.id).where(catchup_id: @catchup.id).first
      guest.declined!

      notifications = Notification.where(user_id: current_user.id)
      notifications.each do |notification|
        content = JSON.parse(notification.content)
        if content["catchup_id"] == @catchup.id
          notification.update(dismissed: true)
        end
      end

      respond_to do |format|
        format.js
      end
    elsif params[:catchup_invitation_id].present?
      puts "RECEIVED A REQUEST FOR CATCHUP INVITATION card with id #{params[:catchup_invitation_id]}"
      @catchup = Catchup.find(params[:catchup_invitation_id])
      @organiser = User.find(@catchup.user_id)
      @action = "add"
      respond_to do |format|
        format.js
      end
    else
      @catchups = current_user.catchups.sort_by(&:time)
      @catchups_accepted_invitations = Catchup.joins(:guests).where(guests: { user_id: current_user.id }).where(guests: { status: "accepted" }).sort_by(&:time)
      @catchups_pending_invitations = Catchup.joins(:guests).where(guests: { user_id: current_user.id }).where(guests: { status: "pending" }).sort_by(&:time)
    end
  end

  def new
    @friends = current_user.friends.sort_by(&:first_name)
    favourite_spots = current_user.favourite_spots.map { |spot| spot }
    wishlist_spots = current_user.wishlist_spots.map { |spot| spot }

    # avoid duplication
    favourite_ids = favourite_spots.map(&:id)
    wishlist_spots = wishlist_spots.reject { |spot| favourite_ids.include?(spot.id) }

    @spots = favourite_spots.concat(wishlist_spots).sort_by(&:name)
  end

  def create
    catchup = Catchup.new
    catchup.user = current_user

    spot_id_array = []
    params[:spot].each { |key, value| spot_id_array << key if value == "true" }
    catchup.spot_id = spot_id_array.first

    date_hash = {}
    params[:date].each { |key, value| date_hash[key] = value.to_i }

    time_hash = {}
    time_hash["hour"] = params[:time]["hour"].to_i
    time_hash["minute"] = params[:time]["minute"].to_i

    # 12 to 24 hour conversion
    time_hash["hour"] = 0 if time_hash["hour"] == 12 && params[:time]["ampm"] == "AM"
    time_hash["hour"] += 12 if params[:time]["ampm"] == "PM"
    time_hash["hour"] = 12 if time_hash["hour"] == 24

    datetime = DateTime.new(date_hash["year"], date_hash["month"], date_hash["day"], time_hash["hour"], time_hash["minute"])
    catchup.time = datetime

    friend_ids = []
    params[:friend].each { |key, value| friend_ids << key if value == "true" }

    if catchup.save
      friend_ids.each do |id|
        guest = Guest.new
        guest.user_id = id
        guest.catchup = catchup
        guest.save
        create_catchup_invite(id, catchup.id)
      end
      redirect_to catchups_path
    end
  end

  private

  def create_catchup_invite(id, catchup_id)
    notification = Notification.new
    notification.user_id = id
    notification.catchup!
    notification.content = { catchup_id: catchup_id }.to_json
    notification.save!
    ActionCable.server.broadcast("catchup#{id}", message: 'alert')
  end
end
