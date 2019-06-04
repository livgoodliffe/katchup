class ListsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
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
