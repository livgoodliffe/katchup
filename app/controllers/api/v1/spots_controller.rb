class Api::V1::SpotsController < Api::V1::BaseController
  before_action :set_spot, only: [ :show ]

  def index
    @spots = policy_scope(Spot)
    # makes sure pundit is being used
  end

  def show
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
    # authorize @spot  # For Pundit - dont need this because all users can see details on all spots?
  end
end
