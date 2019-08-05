class Api::V1::ReviewsController < Api::V1::BaseController

  def index
    @reviews = policy_scope(Review)
  end

  def show
    @spots = Spot.find(params[:id])
    authorise @spot
  end

end

