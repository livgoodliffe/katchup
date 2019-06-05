class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @spots = Spot.all
    @spots_with_coords = @spots.select { |spot| spot.latitude.present? && spot.longitude.present? }
    @markers = @spots_with_coords.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        infoWindow: render_to_string(partial: "map_marker_info", locals: { spot: spot })
      }
    end
    # @spots = Spot.all
  end
end
