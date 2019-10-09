class Api::V1::UsersController < Api::V1::BaseController

  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

end
