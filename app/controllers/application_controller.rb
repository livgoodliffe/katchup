class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :first_name, :last_name, :avatar, :latitude, :longitude) }
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
