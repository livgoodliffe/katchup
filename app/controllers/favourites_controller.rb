class FavouritesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_favourite, only: :destroy
  before_action :set_spot, only: :create

  def index
    @favourites = current_user.favourites
    @favourite_spots = current_user.favourite_spots.sort_by(&:name)
  end

  def create
    # byebug
    @spot = Spot.find(params[:spot_id])
    # remove from wishlist if you are adding it to your 'ive been there' list
    current_user.wishlists.destroy(in_wishlist?(@spot)) if in_wishlist?(@spot)
    current_user.favourites.create(spot: @spot)

    respond_to do |format|
      format.html { redirect_to @spot }
      format.js
    end
  end

  def destroy
    favourite = Favourite.find(params[:id])
    @spot = favourite.spot
    favourite.destroy

    respond_to do |format|
      format.html { redirect_to @spot }
      format.js
    end
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def favourite_params
    params.require(:favourite).permit(:spot_id)
  end

  def in_wishlist?(spot)
    current_user.wishlists.find_by spot_id: spot[:id]
  end
end
