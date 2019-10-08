class Api::V1::SpotsController < Api::V1::BaseController
  def index
    @spots = policy_scope(Spot)
    # makes sure pundit is being used
  end
end
