class SpotsController < ApplicationController

  require "json"
  require "optparse"
  require "http"

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    @client = Romato::Zomato.new(ENV["ZOMATO_API"])
    term = params[:query]
    results = @client.get_search( { q: term, lat: current_user.latitude, lon: current_user.longitude } )
    @spots = results["restaurants"]

  end

  def create

    # if Spot.find(params[:res_id]) ! nil
    #   @spot = Spot.find(params[:res_id])
    #   redirect_to spot_path(@spot)

    # else
      @spot = Spot.new(
        res_id: params[:res_id],
        name: params[:name],
        thumbnail: params[:thumbnail],
        suburb: params[:suburb],
        city: params[:city],
        latitude: params[:latitude],
        longitude: params[:longitude],
        )
      @spot.save
      redirect_to spot_path(@spot)
    # end

  end

  def show
    @spot = Spot.find(params[:id])
  end




  # def index
  #   @spots = Spot.where.not(latitude: nil, longitude: nil)

  #   @markers = @spots.map do |spot|
  #     {
  #       lat: spot.latitude,
  #       lng: spot.longitude,
  #       infoWindow: render_to_string(partial: "maps/map_marker_info", locals: { spot: spot })
  #     }
  #   end
  # end

  # def show
  #   @spot = Spot.find(params[:id])
  #   @review = Review.new
  #   @marker = [{
  #     lat: @spot.latitude,
  #     lng: @spot.longitude,
  #     infoWindow: render_to_string(partial: "maps/map_marker_info", locals: { spot: @spot })
  #   }]

  #   render :layout => 'without_navbar'
  # end
end
