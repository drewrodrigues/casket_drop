class OrdersController < ApplicationController
  before_action :require_login!
  before_action :require_admin!
  before_action :set_order, except: %i[index new create]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to(@order)
    else
      render(:new)
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to(@order)
    else
      render :edit
    end
  end

  def destroy
    if @order.delete
      redirect_to orders_path
    else
      redirect_to @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :details, :user_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
