class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params.key?(:response_dismiss)
      @guest = Guest.find(params[:guest_response_id])

      # let js partial know that the guest response card is to be removed
      @action = "remove_response"

      # dismiss the guest invite notification so that it doesn't reappear on the guest's browser
      dismiss_guest_notification

      # send js response partial
      respond_to do |format|
        format.js
      end
    elsif params.key?(:guest_response_id)
      @guest = Guest.find(params[:guest_response_id])

      # let js partial know that the guest response card is to be created
      @action = "add_response"

      # send js response partial
      respond_to do |format|
        format.js
      end
    elsif params.key?(:catchup_accept) # accept respoinse to catchup you're invited to
      @catchup = Catchup.find(params[:catchup_invitation_id])

      # let js partial know that the invite card is to be removed
      @action = "remove_invite"

      # get the guest instance and set status to accept
      guest = Guest.where(user_id: current_user.id).where(catchup_id: @catchup.id).first
      guest.accepted!

      # dismiss the guest invite notification so that it doesn't reappear on the guest's browser
      dismiss_catchup_notification

      # create notification for organiser to let them know the user has accepted
      create_guest_status_notification(@catchup.user_id, guest.id)

      # send js response partial
      respond_to do |format|
        format.js
      end
    elsif params.key?(:catchup_decline) # decline response to catchup you're invited to
      @catchup = Catchup.find(params[:catchup_invitation_id])

      # let js partial know that the invite card is to be removed
      @action = "remove_invite"

      # get the guest instance and set status to decline
      guest = Guest.where(user_id: current_user.id).where(catchup_id: @catchup.id).first
      guest.declined!

      # dismiss the guest invite notification so that it doesn't reappear on the guest's browser
      dismiss_catchup_notification

      # create notification for organiser to let them know the user has declined
      create_guest_status_notification(@catchup.user_id, guest.id)

      # send js response partial
      respond_to do |format|
        format.js
      end
    elsif params.key?(:catchup_invitation_id) # catchup you're invited to
      @catchup = Catchup.find(params[:catchup_invitation_id])
      @organiser = User.find(@catchup.user_id)

      # let js partial know that the invite card is to created
      @action = "add_invite"

      # send js response partial
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
        create_catchup_invite_notification(id, catchup.id)
      end
      flash[:notice] = "Katchup Created!"
      redirect_to catchups_path
    end
  end

  private

  def create_catchup_invite_notification(id, catchup_id)
    notification = Notification.new
    notification.user_id = id
    notification.catchup!
    notification.content = { catchup_id: catchup_id }.to_json
    notification.save
  end

  def dismiss_catchup_notification
    notifications = Notification.where(user_id: current_user.id)
    notifications.each do |notification|
      if notification.catchup?
        content = JSON.parse(notification.content)
        notification.update(dismissed: true) if content["catchup_id"] == @catchup.id
      end
    end
  end

  def create_guest_status_notification(organiser_id, guest_id)
    notification = Notification.new
    notification.user_id = organiser_id
    notification.guest!
    notification.content = { guest_id: guest_id }.to_json
    notification.save
  end

  def dismiss_guest_notification
    notifications = Notification.where(user_id: current_user.id)
    notifications.each do |notification|
      if notification.guest?
        content = JSON.parse(notification.content)
        notification.update(dismissed: true) if content["guest_id"] == @guest.id
      end
    end
  end
end
