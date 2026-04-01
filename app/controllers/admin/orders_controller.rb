# app/controllers/admin/orders_controller.rb
class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to admin_orders_path, notice: "Order created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: "Order updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_path, notice: "Order deleted successfully."
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :status, :total_price)
  end
end




