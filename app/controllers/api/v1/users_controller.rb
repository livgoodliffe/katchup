class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :edit, :update, :destroy]
  # before_action :logged_in_user, only: [:edit, :update]
  # before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
