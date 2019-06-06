class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    # get correct spots
    favourite_spots = spots_with_coords_array(current_user.favourite_spots)
    wishlist_spots = spots_with_coords_array(current_user.wishlist_spots)

    # prevent spots with both marker types, favourite prevails
    favourite_ids = favourite_spots.map(&:id)
    wishlist_spots = wishlist_spots.reject { |spot| favourite_ids.include?(spot.id) }

    # create markers
    @markers_favourite = create_markers(favourite_spots)
    @markers_wishlist = create_markers(wishlist_spots)

    @marker_user = create_user_marker if user_has_coords?
    @marker_user_avatar = current_user.avatar.url
  end

  private

  def spots_with_coords_array(spots)
    spots_with_coords = spots.select do |spot|
      spot.latitude.present? && spot.longitude.present?
    end
    spots_with_coords.map { |spot| spot }
  end

  def create_markers(spots)
    spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        infoWindow: render_to_string(partial: "map_marker_info", locals: { spot: spot })
      }
    end
  end

  def user_has_coords?
    current_user.latitude.present? && current_user.longitude.present?
  end

  def create_user_marker
    [{ lat: current_user.latitude,
       lng: current_user.longitude }]
  end
end
