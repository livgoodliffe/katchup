class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity
                  .paginate(page: params[:page], per_page: 15)
                  .order('created_at DESC')
                  .where(owner_id: current_user.friends)
                  .where("key ilike ?", "%create%")
    # byebug
    respond_to do |format|
      format.html
      format.js
    end

    @spots = Spot.all

    # spots = spots_with_coords_array(Spot.all)

    # @markers_spot = create_markers(spots)

    # @marker_user = create_user_marker if user_has_coords?
    # @marker_user_avatar = current_user.avatar.url
  end

  # Map was deleted from feed

  # private

  # def spots_with_coords_array(spots)
  #   spots_with_coords = spots.select do |spot|
  #     spot.latitude.present? && spot.longitude.present?
  #   end
  #   spots_with_coords.map { |spot| spot }
  # end

  # def create_markers(spots)
  #   spots.map do |spot|
  #     {
  #       lat: spot.latitude,
  #       lng: spot.longitude,
  #       infoWindow: render_to_string(partial: "lists/map_marker_info", locals: { spot: spot })
  #     }
  #   end
  # end

  # def user_has_coords?
  #   current_user.latitude.present? && current_user.longitude.present?
  # end

  # def create_user_marker
  #   [{ lat: current_user.latitude,
  #      lng: current_user.longitude,
  #      infoWindow: render_to_string(partial: "lists/user_marker_info") }]
  # end
end
