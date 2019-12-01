class FeedsController < ApplicationController
  #remove this after live
  skip_before_action :authenticate_user!, only: [:index]

  def index

  end
end
