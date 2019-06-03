class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end
end
