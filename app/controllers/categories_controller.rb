# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  def index
    @categories = Category.all.distinct.order(:name)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc).page(params[:page]).per(10)
  end
end
