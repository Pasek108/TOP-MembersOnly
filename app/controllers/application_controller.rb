class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_path, alert: "Not authorized" if current_user.nil?
  end

  def block_if_authorized
    redirect_to root_path, alert: "You are already logged in" unless current_user.nil?
  end
end
