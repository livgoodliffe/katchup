class FeedsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @stuff = Spot.all
  end
end
