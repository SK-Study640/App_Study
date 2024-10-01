class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?  # Added to avoid system errors by ensuring Devise helper methods run only in Devise controllers.


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
