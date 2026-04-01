# app/controllers/admin/home_controller.rb
class Admin::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @total_products   = Product.count
    @total_categories = Category.count
    @total_orders     = Order.count
    @recent_products  = Product.order(created_at: :desc).limit(5)
    @recent_orders    = Order.order(created_at: :desc).limit(5)
  end
end