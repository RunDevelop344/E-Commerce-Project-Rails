class ProductsController < ApplicationController
  def index
    @products = Product.all.order(created_at: :desc)
    if params[:keyword].present?
      @products = @products.where(
        "name ILIKE ? OR description ILIKE ?",
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
      )
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
