require 'byebug'
class DiscoverController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # byebug
    if params[:search].present?
      search = params[:search]
      @spots = Spot.where('name ILIKE ?', "%#{search}%")
      respond_to do |format|
        format.js
      end
    else
      @spots = Spot.all
      friends_loving
    end
  end

  def friends_loving
    @friends_spots = []
    current_user.friends.each do |friend|
      friend.reviews.each do |review|
        if review.rating >= 4
          unless @friends_spots.include? review.spot
            @friends_spots << review.spot
          end
        end
      end
    end
    @friends_spots
  end
end
