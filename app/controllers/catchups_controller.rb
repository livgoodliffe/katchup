class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @catchups = current_user.catchups.sort_by(&:time)
    @catchups_invitations = current_user.catchups_invitations.sort_by(&:time)
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

    #12 to 24 hour conversion
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
        ActionCable.server.broadcast("catchup#{id}", message: 'You have been invited to catchup!')
    end
      redirect_to catchups_path
    end
  end
end
