class PagesController < ApplicationController
  require "json"
  require "optparse"
  require "http"

  # API_HOST = "https://api.yelp.com"
  # SEARCH_PATH = "/v3/businesses/search"
  # BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  # API_KEY = ENV["YELP_API"]
  # SEARCH_LIMIT = 3
  # GP_API = ENV["GOOGLE_PLACES"]

  # skip_before_action :authenticate_user!, only: [:home]

  def home
    # checks if user is signed in and redirect root to feeds_path
    if user_signed_in?
      redirect_to feeds_path
    else
      render :layout => 'without_navbar'
    end
  end

  def kitchen_sink
  end

  def search

    @client = Romato::Zomato.new(ENV["ZOMATO_API"])
    term = params[:query]
    results = @client.get_search( { q: term, lat: current_user.latitude, lon: current_user.longitude } )
    @spots = results["restaurants"]

    # GOOGLE PLACES WORKING SEARCH
    # @client = GooglePlaces::Client.new(GP_API)
    # @nearby = @client.spots(current_user.latitude, current_user.longitude, :types => ['restaurant', 'cafe', 'bar'])
    # @search = @client.spots_by_query(term, :types => ['food'])

    # YELP WORKING SEARCH
    # url = "#{API_HOST}#{SEARCH_PATH}"
    # params = {
    #   term: term,
    #   latitude: current_user.latitude,
    #   longitude: current_user.longitude,
    #   limit: SEARCH_LIMIT
    # }
    # response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    # @restaurants = response.parse["businesses"]

  end

end
