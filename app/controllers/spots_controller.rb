class SpotsController < ApplicationController

  require "json"
  require "optparse"
  require "http"

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    term = params[:query]
    # search in database first
    @spots_db = Spot.where('name ILIKE ?', "%#{term}%")
    # search in zomato
    @client = Romato::Zomato.new(ENV["ZOMATO_API"])
    results = @client.get_search( { q: term, lat: current_user.latitude, lon: current_user.longitude } )
    @zom_results = results["restaurants"]
    # if zomato result is in DB don't show it
    # if spots_db and spots_zom results have same res_id, only show spot_db
    @spots_zom = []
    # check if any zomato results are in db
    @zom_results.each do |spot|
      zom_res_id = spot["restaurant"]["R"]["res_id"]
      result = Spot.exists?(res_id: zom_res_id)
      if result == false
        @spots_zom.push(spot)
      end
    end
    @spots_zom
    @spots_db

    # News feed

    @activities = PublicActivity::Activity
                  .paginate(page: params[:page], per_page: 15)
                  .order('created_at DESC')
                  .where(owner_id: current_user.friends)
                  .where("key ilike ?", "%create%")
    respond_to do |format|
      format.html
      format.js
    end

    @spots = Spot.all

  end

  def create

    # for the zomato results

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
