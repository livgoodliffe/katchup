class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @friends = current_user.friends
    favourite_spots = current_user.favourite_spots.map { |spot| spot }
    wishlist_spots = current_user.wishlist_spots.map { |spot| spot }
    @spots = favourite_spots.concat(wishlist_spots)

  end

  def create
    # create catchup
    # create guests
    puts params
    # puts

    render 'catchups/index'
  end
end
