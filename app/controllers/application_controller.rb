class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SlackHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :member_id, :nickname, :first_name, :last_name, :enroll_date, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :member_id, :first_name, :last_name, :enroll_date])
  end
end
