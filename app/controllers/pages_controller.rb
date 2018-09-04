class PagesController < ApplicationController
  before_action :require_login!, only: :dashboard
  before_action :require_admin!, only: :admin

  # GET
  def landing
    if current_user
      redirect_to (admin? ? admin_path : dashboard_path)
    end
  end

  # GET /dashboard
  def dashboard
    redirect_to admin_path if admin?
  end

  # GET /admin
  def admin; end
end
