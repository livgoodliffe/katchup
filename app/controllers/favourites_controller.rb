class FavouritesController < ApplicationController
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
      format.js { render :create }
    end
  end
end
