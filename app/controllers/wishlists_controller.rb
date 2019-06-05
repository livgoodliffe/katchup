class WishlistsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_wishlist, only: :destroy
  before_action :set_spot, only: :create

  def index
    @wishlist = current_user.wishlists
    @wishlist_spots = current_user.wishlist_spots.sort_by(&:name)
  end

  def create
    @spot = Spot.find(params[:spot_id])
    current_user.wishlists.create(spot: @spot)

    respond_to do |format|
      format.html { redirect_to @spot }
      format.js
    end
  end

  def destroy
    wishlist = Wishlist.find(params[:id])
    @spot = wishlist.spot
    wishlist.destroy

    respond_to do |format|
      format.html { redirect_to @spot }
      format.js
    end
  end

  private

  def set_wishlist
    @wishlist = Wishlist.find(params[:id])
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:spot_id)
  end
end
