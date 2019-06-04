class DiscoverController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @spots = Spot.all
  end
end
