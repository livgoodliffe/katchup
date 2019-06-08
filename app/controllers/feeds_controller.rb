class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @activities = PublicActivity::Activity
                  .order("created_at desc")
                  .where(owner_id: current_user.friends)
                  .where("key ilike ?", "%create%")

    if params[:search].present?
      search = params[:search]
      @spots = Spot.where('name ILIKE ?', "%#{search}%")
      respond_to do |format|
        format.js
      end
    else
      @spots = Spot.all
    end
  end

end
