class SubscriptionsController < ApplicationController
  before_action :require_login!
  before_action :set_user, on: [:new, :create]

  def new
    @api_key = ENV["THREAD_BOX_STRIPE_PUB_KEY"] # FIXME: better way to do this?
  end

  def create
    if @user.save(subscription_params)
      @user.subscribe(params[:stripeToken])
      redirect_to dashboard_path
    else
      render :new
    end
  end
  
  private
  
  def subscription_params
    params.require(:stripeToken)
    params.require(:user).permit(:address, :city, :state)
  end

  def set_user
    @user = current_user
  end
end
