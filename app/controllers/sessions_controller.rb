class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  before_action :set_user, only: %i[new create]
  before_action :redirect_if_new_email, only: %i[create]

  # GET /login
  def new
    @passed_email = params[:email]
  end

  # POST /login
  def create
    if @user&.authenticate(password)
      login(@user)
      redirect_to (@user.admin ? admin_path : dashboard_path)
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

  def set_user
    @user = User.find_by(email: email)
  end

  def redirect_if_new_email
    # TODO: test this in controller spec (& pass email over)
    redirect_to get_started_path(email) if (!@user && email)
  end
end
