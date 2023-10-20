class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  # load_and_authorize_resource

  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    users_path
  end

  private

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :photo, :bio, :email, :posts_counter, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :bio, :posts_counter, :email, :password, :current_password)
    end
  end
end
