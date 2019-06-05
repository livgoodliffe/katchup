class UsersController < ApplicationController
  def show
    @current_user = current_user
    @params = params
  end

  def index
    @params = params
    @users = User.all.where.not(id: current_user.id)
  end
end
