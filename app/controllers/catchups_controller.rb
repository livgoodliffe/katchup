class CatchupsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @friends = current_user.friends
  end

  def create
    # create catchup
    # create guests

  end
end
