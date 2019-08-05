class Api::V1::SessionsController < ActionController::API
  def create
    # login
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      render json: @user.as_json(only: [:email, :authentication_token, :firstName, :lastName]), status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    # logout
    current_user&.authentication_token = nil

    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end
