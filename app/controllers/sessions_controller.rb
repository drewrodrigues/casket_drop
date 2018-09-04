class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  # GET /login
  def new; end

  # POST /login
  def create
    user = User.find_by(email: email)
    if user&.authenticate(password)
      login(user)
      redirect_to (user.admin ? admin_path : dashboard_path)
    else
      @error = "There was a problem with your login."
      render :new
    end
  end

  # DELETE /logout
  def destroy
    logout
    redirect_to login_path
  end

  private

  def email
    params[:email]
  end

  def password
    params[:password]
  end
end
