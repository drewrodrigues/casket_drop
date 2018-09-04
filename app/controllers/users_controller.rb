class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action :require_user!, except: %i[new create index]
  before_action :require_admin!, only: [:index]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to subscribe_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      logout
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_if_logged_in
    if admin?
      redirect_to admin_path
    elsif user?
      redirect_to dashboard_path
    end
  end

  def set_user
    raise ActionController::RoutingError.new("Page not found") if params[:id].to_i != current_user.id && !admin?
    @user = User.find(params[:id])
  end

  def require_user!
    redirect_to login_path unless user?
  end

  def require_admin!
    raise ActionController::RoutingError.new("Page not found") unless admin?
  end
end
