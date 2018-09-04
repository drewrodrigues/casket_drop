class ApplicationController < ActionController::Base
  def login(user)
    session[:user] = user
  end

  def logout
    session.delete :user
  end

  def user?
    !!session[:user]
  end

  def admin?
    session[:user] && session[:user][:admin]
  end

  def current_user
    @current_user || User.find(session[:user][:id])
  end
end
