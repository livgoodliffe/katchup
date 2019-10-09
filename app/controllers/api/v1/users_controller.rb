class Api::V1::UsersController < Api::V1::BaseController

  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render text: @user.authentication_token, status: 201
    else
      render json: @user.errors, status: 422
    end

    # do i have to authorise or use pundit
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
