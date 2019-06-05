class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @search = params[:search]
    @search_type = params[:search_type]
    @location = params[:result_location]

    return unless @search_type.present?

    case @search_type
    when 'all_spots'
      general_search
    when 'favourite_spots'
      favourite_search
    when 'wishlist_spots'
      wishlist_search
    end
  end

  private

  def general_search
    @spots = Spot.where('name ILIKE ?', "%#{@search}%")
    respond_to do |format|
      format.js
    end
  end

  def favourite_search
    return if current_user.nil?

    @spots = current_user.favourite_spots.where('name ILIKE ?', "%#{@search}%")
    respond_to do |format|
      format.js
    end
  end

  def wishlist_search
    return if current_user.nil?

    @spots = current_user.favourite_spots.where('name ILIKE ?', "%#{@search}%")
    respond_to do |format|
      format.js
    end
  end
end
