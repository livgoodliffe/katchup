class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity
                  .paginate(page: params[:page], per_page: 15)
                  .order('created_at DESC')
                  .where(owner_id: current_user.friends)
                  .where("key ilike ?", "%create%")
    respond_to do |format|
      format.html
      format.js
    end

    @spots = Spot.all

  end
end
