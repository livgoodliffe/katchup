class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity
                  .order("created_at desc")
                  .where(owner_id: current_user.friends)
                  .where("key ilike ?", "%create%")

    if params[:search].present?
      search = params[:search]
      @spots = Spot.where('name ILIKE ?', "%#{search}%")
      respond_to do |format|
        format.js
      end
    else
      @spots = Spot.all
    end

    @spots = Spot.all

    all_spots = spots_with_coords_array(@spots)

    @markers_spots = create_markers(all_spots)

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
        # infoWindow: render_to_string(partial: "map_marker_info", locals: { spot: spot })
      }
    end
  end

  def user_has_coords?
    current_user.latitude.present? && current_user.longitude.present?
  end

  def create_user_marker
    [{ lat: current_user.latitude,
       lng: current_user.longitude,
       # infoWindow: render_to_string(partial: "user_marker_info" )
     }]
  end
end
