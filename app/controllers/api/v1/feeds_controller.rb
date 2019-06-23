class Api::V1::FeedsController < Api::V1::BaseController

  def index
    @spots = policy_scope(Spot)
  end

end
