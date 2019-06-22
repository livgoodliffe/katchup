class Api::V1::ReviewsController < Api::V1::BaseController
  def index
    @reviews = policy_scope(Review)
  end
end
