# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? # Added to avoid system errors by ensuring Devise helper methods run only in Devise controllers.
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def authenticate_user
    return if user_signed_in?

    redirect_to new_user_session_path, notice: 'ログインしてください'
  end
end
