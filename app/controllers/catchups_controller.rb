class CatchupsController < ApplicationController
  def index
  end

  def new
    @users = User.all.where.not(id: current_user.id)
  end
end
