class FeedsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity.all
    # byebug

  #   my_friendships.each do |friendship|
  #     wishlists = friendship.friend.wishlists
  #     wishlists.each do |wishlist|
  #       @spots << wishlist.spot
  #       # byebug
  #     end
  #   end
  #   # get the current user's friends favourites items
  #   my_friendships.each do |friendship|
  #     favourites = friendship.friend.favourites
  #     favourites.each do |favourite|
  #       @spots << favourite.spot
  #       # binding.pry
  #     end
  #   end
  #   # get the curren users's friends reviewed item
  #   my_friendships.each do |friendship|
  #     reviewed = friendship.friend.reviews
  #     reviewed.each do |review|
  #       @spots << review.spot
  #       # binding.pry
  #     end
  #   end
  end
end
