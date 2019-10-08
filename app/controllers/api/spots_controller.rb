class Api::SpotsController < Api::BaseController
  before_action :set_spot, only: [ :show ]

  def index
    @spots = Spot.all
  end

  def show
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end
end
