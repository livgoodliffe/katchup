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
      render json: @user.as_json(only: [:authentication_token]), status: :created
    else
      head(:unprocessable_entity)
    end

    authorize @user

  end

  private

  def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
