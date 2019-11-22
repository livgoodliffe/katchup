class PagesController < ApplicationController
  require "json"
  require "optparse"
  require "http"

  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  API_KEY = ENV["YELP_API"]

  DEFAULT_BUSINESS_ID = "yelp-san-francisco"
  DEFAULT_TERM = "dinner"
  DEFAULT_LOCATION = "New York, NY"
  SEARCH_LIMIT = 10

  skip_before_action :authenticate_user!, only: [:home]

  def home
    render :layout => 'without_navbar'
  end

  def kitchen_sink
  end

  def search

    # @spots = Spot.all

    url = "#{API_HOST}#{SEARCH_PATH}"

    term = params[:query]

    # location is user's location

    params = {
      term: term,
      location: "melbourne",
      limit: SEARCH_LIMIT
    }

    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    @restaurants = response.parse["businesses"]

  end
end
