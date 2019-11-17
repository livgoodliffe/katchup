class Api::V1::SpotsController < Api::V1::BaseController

  skip_before_action :authenticate_user!

  def index
    @spots = Spot.all

    render json: @spots

  end

  def show
    @spot = Spot.find(params[:id])
    authorize @spot

    @review = Review.new
  end

end
