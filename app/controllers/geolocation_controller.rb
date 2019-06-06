class GeolocationController < ApplicationController
  def index

    return if current_user.nil?
    return if params[:user_latitude].nil?
    return if params[:user_longitude].nil?

    current_user.update(latitude: params[:user_latitude].to_f, longitude: params[:user_longitude].to_f)
  end
end
