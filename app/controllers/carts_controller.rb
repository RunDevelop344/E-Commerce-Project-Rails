class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @cart_items = build_cart_items(@cart)
  end

  def add_item
    @cart = session[:cart] || {}
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i || 1
    @cart[product_id] = (@cart[product_id] || 0) + quantity
    session[:cart] = @cart
    redirect_to cart_path, notice: "Item added to cart."
  end

  def update_item
    @cart = session[:cart] || {}
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    if quantity > 0
      @cart[product_id] = quantity
    else
      @cart.delete(product_id)
    end
    session[:cart] = @cart
    redirect_to cart_path, notice: "Cart updated."
  end

  def remove_item
    @cart = session[:cart] || {}
    @cart.delete(params[:product_id].to_s)
    session[:cart] = @cart
    redirect_to cart_path, notice: "Item removed."
  end

  private

  def build_cart_items(cart)
    cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      { product: product, quantity: quantity, subtotal: product.price * quantity }
    end.compact
  end
end