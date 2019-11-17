class Api::V1::SpotsController < Api::V1::BaseController
  # before_action :set_spot, only: [ :show ]
  skip_before_action :authenticate_user!


  def index   def index
    @spots = policy_scope(Spot)     @spots = Spot.all
    # makes sure pundit is being used
    render json: @spots

  end   end


  def show    def show
    @spot = Spot.find(params[:id])      @spot = Spot.find(params[:id])
    authorize @spot     authorize @spot
  end


  # private     @review = Review.new
  end


  # def set_spot
  #   @spot = Spot.find(params[:id])
  #   authorize @spot  # For Pundit - dont need this because all users can see details on all spots?
  # end
end
