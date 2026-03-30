module Admin
  class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin   # uses ApplicationController method

    def index
      @total_products = Product.count
      @total_categories = Category.count
      @total_orders = Order.count
    end
  end
end