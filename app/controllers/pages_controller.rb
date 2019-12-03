class PagesController < ApplicationController
  require "json"
  require "optparse"
  require "http"

  skip_before_action :authenticate_user!, only: [:home]


  def home
    # checks if user is signed in and redirect root to spots_path
    if user_signed_in?
      redirect_to spots_path
    else
      render :layout => 'without_navbar'
    end
  end

  def kitchen_sink
  end

  def search

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

    @spots_db
    @spots_zom
  end

end
