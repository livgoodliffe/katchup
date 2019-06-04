class FavouritesController < ApplicationController
  before_action :set_favourite, only: :destroy
  before_action :set_spot, only: :create

  def index
    @favourites = Favourite.where(user: current_user)
  end

  def create
    @spot = Spot.find(params[:spot_id])
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
end
