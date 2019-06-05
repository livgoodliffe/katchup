class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @search = params[:search]
    @search_type = params[:search_type]
    @location = params[:result_location]

    return unless @search_type.present?

    case @search_type
    when 'all_spots'
      all_spots_search
    when 'my_spots'
      my_spots_search
    when 'favourite_spots'
      favourite_search
    when 'wishlist_spots'
      wishlist_search
    end
  end

  private

  def all_spots_search
    @spots = Spot.where('name ILIKE ?', "%#{@search}%")
    respond_to do |format|
      format.js
    end
  end

  def my_spots_search
    return if current_user.nil?

    @spots = []

    spots_filtered_favourite = current_user.favourite_spots.where('name ILIKE ?', "%#{@search}%")
    spots_filtered_wishlist = current_user.wishlist_spots.where('name ILIKE ?', "%#{@search}%")

    spots_filtered_favourite.each { |spot| @spots << spot }
    spots_filtered_wishlist.each { |spot| @spots << spot }

    @spots = [] if @search.blank?

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

    @spots = current_user.wishlist_spots.where('name ILIKE ?', "%#{@search}%")
    respond_to do |format|
      format.js
    end
  end
end
