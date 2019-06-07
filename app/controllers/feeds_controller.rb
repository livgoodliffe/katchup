class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friends)
    # byebug
  end
end
