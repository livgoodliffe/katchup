class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    render :layout => 'without_navbar'
  end

  def kitchen_sink
  end
end
