class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_user, only: %i[follow unfollow]

  def show
    @current_user = current_user
    @params = params
    @user = User.find(params[:id])
    @wishlists = Wishlist.where(user_id: @user)
    @favourites = Favourite.where(user_id: @user)
    @friends = Friendship.where(user_id: @user)
    @reviews = Review.where(user_id: @user)
  end

  def create
  end

  def index
    @params = params
    @users = User.all.where.not(id: current_user.id)
    # @friends = Friendship.where(user_id: current_user)
  end

  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :follow }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
