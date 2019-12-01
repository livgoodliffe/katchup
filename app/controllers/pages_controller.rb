class PagesController < ApplicationController
  require "json"
  require "optparse"
  require "http"

  skip_before_action :authenticate_user!, only: [:home]


  def home
    # checks if user is signed in and redirect root to spots_path
    if user_signed_in?
      redirect_to spots_path
    else
      render :layout => 'without_navbar'
    end
  end

  def kitchen_sink
  end

end
