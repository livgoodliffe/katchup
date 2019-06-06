class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @friends = current_user.friends
    favourite_spots = current_user.favourite_spots.map { |spot| spot }
    wishlist_spots = current_user.wishlist_spots.map { |spot| spot }

    # avoid duplication
    favourite_ids = favourite_spots.map(&:id)
    wishlist_spots = wishlist_spots.reject { |spot| favourite_ids.include?(spot.id) }

    @spots = favourite_spots.concat(wishlist_spots).sort_by(&:name)
  end

  def create
    # create catchup
    # create guests
    puts params
    # puts

    render 'catchups/index'
  end
end
