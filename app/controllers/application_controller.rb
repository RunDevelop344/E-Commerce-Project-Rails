# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  # Add this method HERE
  def require_admin
    redirect_to root_path, alert: "Not authorized" unless current_user&.role == "admin"
  end

  # Redirect users to home page after login
  def after_sign_in_path_for(resource)
    root_path
  end

  # Optional: redirect users to login page after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end