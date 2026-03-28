# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Redirect users to home page after login
  def after_sign_in_path_for(resource)
    puts "Redirecting user #{resource.email} to home page"
  "/"
    root_path
  end

  # Optional: redirect users to login page after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end