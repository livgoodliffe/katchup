class Api::V1::UsersController < Api::V1::BaseController

  def index
    respond_with User.all
  end

end



#   def index
#       respond_with User.all
#   end

#   def show
#       respond_with User.find(params[:id])
#   end

#   def new
#       @user = User.new
#   end

#   def create
#       @user = User.create(user_params)
#       # respond_with(@user)

#       if @user.save
#           # render json: @user, status: :created, location: @user
#           redirect_to @user
#       end
#   end

#   private

#       def user_params
#         params.require(:user).permit(:name, :email, :location) if params[:user]
#       end
#     end
#   end
# end
