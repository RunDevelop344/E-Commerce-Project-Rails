class HomeController < ApplicationController
  # Require user login
  before_action :authenticate_user!

  def index
    # Here you can fetch any data for the dashboard
    @total_products = Product.count
    @total_categories = Category.count
    @total_orders = Order.count # if you have an Order model
  end
end