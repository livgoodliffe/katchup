class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @spots = Spot.where.not(latitude: nil, longitude: nil)

    @markers = @spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        infoWindow: render_to_string(partial: "maps/map_marker_info", locals: { spot: spot })
      }
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @review = Review.new
    @marker = [{
      lat: @spot.latitude,
      lng: @spot.longitude,
      infoWindow: render_to_string(partial: "maps/map_marker_info", locals: { spot: @spot })
    }]

    render :layout => 'without_navbar'
  end
end
