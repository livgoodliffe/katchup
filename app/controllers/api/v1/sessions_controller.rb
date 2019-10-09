class Api::V1::SessionsController < Api::V1::BaseController

# CODEMY

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      render json: @user.as_json(only: [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    current_user&.authentication_token = nil

    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end


# ISAAC
  #   def new
  #   end

  #   #If user login data are valid it will return the authentication_token so the
  #   #client app can use it for future request for the specific user.

  #   def create
  #     user = User.find_by(email: params[:session][:email].downcase)
  #       if user && user.authenticate(params[:session][:password])
  #         render :text => user.authentication_token, status: 200
  #       else
  #         render text: "Email and password combination are invalid", status: 422
  #       end
  #   end

  #   #Verifies the authentication_token so the client app would know if to login the user.

  #   def verify_authentication_token
  #     user = User.find_by(authentication_token: params[:session][:authentication_token])
  #       if user
  #         render text: "verified", status: 200
  #       else
  #         render text: "Token failed verification", status: 422
  #       end
  #   end

  # end
end



