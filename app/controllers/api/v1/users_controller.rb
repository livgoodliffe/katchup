class Api::V1::SpotsController < Api::V1::BaseController
  def index
    @users = policy_scope(User)
  end
end
