class SpotsController < ApplicationController

  require "json"
  require "optparse"
  require "http"

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    term = params[:query]

    @spots_db = Spot.where('name ILIKE ?', "%#{term}%")

    @client = Romato::Zomato.new(ENV["ZOMATO_API"])
    results = @client.get_search( { q: term, lat: current_user.latitude, lon: current_user.longitude } )
    @zom_results = results["restaurants"]

    @spots_zom = []

    @zom_results.each do |spot|
      zom_res_id = spot["restaurant"]["R"]["res_id"]
      result = Spot.exists?(res_id: zom_res_id)
      if result == false
        @spots_zom.push(spot)
      end
    end

    @spots_zom

    if params[:query]
      respond_to do |format|
        format.html
        format.js{}
      end
    end

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

end
