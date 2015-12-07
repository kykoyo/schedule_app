class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  #need to log in before going any pages
  #before_filter :authenticate_user!



  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource_or_scope)
    user_events_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) <<:username 
    devise_parameter_sanitizer.for(:sign_up) <<:user_type
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:account_update) << :user_type
  end

end
