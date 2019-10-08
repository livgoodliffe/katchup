class Api::SessionsController < Api::BaseController

    def new
    end
    #If user login data are valid it will return the access_token so the
    #client app can use it for future request for the specific user.
    def create
      user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          render :text => user.access_token, status: 200
        else
          render text: "Email and password combination are invalid", status: 422
        end
    end
    #Verifies the access_token so the client app would know if to login the user.
    def verify_access_token
      user = User.find_by(authentication_token: params[:session][:authentication_token])
        if user
          render text: "verified", status: 200
        else
          render text: "Token failed verification", status: 422
        end
    end

  end
end
