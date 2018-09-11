class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  before_action :require_login!, except: %i[new create index]
  before_action :require_admin!, only: :index
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
      login(@user)
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
    deleting_self = (@user == current_user)
    if @user.destroy
      logout if deleting_self
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :address, :bottom_fit,
      :city, :email, :first_name,
      :last_name, :password,
      :shoe_size, :state, :style,
      :top_size, :waist_size
    )
  end

  def set_user
    raise ActionController::RoutingError.new("Page not found") unless can_edit_resource
    @user = User.find(params[:id])
  end

  def can_edit_resource
    params[:id].to_i == current_user.id || admin?
  end
end
