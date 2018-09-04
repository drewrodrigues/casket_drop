class ApplicationController < ActionController::Base
  include ApplicationHelper

  def login(user)
    session[:user] = user
  end

  def logout
    session.delete :user
  end

  def redirect_if_logged_in
    if admin?
      redirect_to admin_path
    elsif user?
      redirect_to dashboard_path
    end
  end

  def require_login!
    redirect_to login_path unless user?
  end

  def require_admin!
    raise ActionController::RoutingError.new("Page not found") unless admin?
  end
end
