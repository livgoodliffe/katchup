class Api::V1::UsersController < ActionController::API

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json(only: [:authentication_token]), status: :created
    else
      head(:unprocessable_entity)
    end
  end

  private

  def user_params # added from codemy
    params.require(:user).permit(
      :firstName, :lastName, :email, :password, :password_confirmation
    )
  end
end
