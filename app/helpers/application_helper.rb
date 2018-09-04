module ApplicationHelper
  def user?
    !!session[:user]
  end

  def admin?
    session[:user] && session[:user]["admin"]
  end

  def current_user
    # TODO: refactor
    return false unless session[:user]
    @current_user || User.find(session[:user]["id"])
  end
end
