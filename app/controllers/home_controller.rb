# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @products = Product.all.order(created_at: :desc)

    # Fix: param names now match what the view form sends
    if params[:product_keyword].present?
      @products = @products.where(
        "name ILIKE ? OR description ILIKE ?",
        "%#{params[:product_keyword]}%",
        "%#{params[:product_keyword]}%"
      )
    end

    if params[:product_category_id].present?
      @products = @products.where(category_id: params[:product_category_id])
    end

    @products = @products.page(params[:page]).per(10)

    # Fix: .distinct removes duplicate categories
    @categories = Category.all.distinct.order(:name)

    if params[:category_keyword].present?
      @categories = @categories.where(
        "name ILIKE ?",
        "%#{params[:category_keyword]}%"
      )
    end
  end
end