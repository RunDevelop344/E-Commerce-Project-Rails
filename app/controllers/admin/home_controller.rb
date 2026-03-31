# app/controllers/admin/home_controller.rb
class Admin::HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_products   = Product.count
    @total_categories = Category.count
    @total_orders     = Order.count
    @recent_products  = Product.order(created_at: :desc).limit(5)
  end
end