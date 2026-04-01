class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cart_not_empty

  def show
    @cart_items = build_cart_items(session[:cart] || {})
    @subtotal   = @cart_items.sum { |i| i[:subtotal] }
    @province   = current_user.province
    calculate_taxes(@subtotal, @province)
    @total      = @subtotal + @gst + @pst + @hst
  end

  def create
    @cart_items = build_cart_items(session[:cart] || {})
    @subtotal   = @cart_items.sum { |i| i[:subtotal] }

    # Use user's province or selected province
    province_id = params[:province_id].present? ? params[:province_id] : current_user.province_id
    @province   = Province.find_by(id: province_id)
    calculate_taxes(@subtotal, @province)
    @total = @subtotal + @gst + @pst + @hst

    order = Order.new(
      user:        current_user,
      province:    @province,
      status:      :new_order,
      subtotal:    @subtotal,
      gst_amount:  @gst,
      pst_amount:  @pst,
      hst_amount:  @hst,
      total:       @total
    )

    # Save address if provided
    if params[:street_address].present?
      current_user.update(
        address:     params[:street_address],
        city:        params[:city],
        postal_code: params[:postal_code],
        province_id: province_id
      )
    end

    if order.save
      @cart_items.each do |item|
        order.order_items.create!(
          product:    item[:product],
          quantity:   item[:quantity],
          unit_price: item[:product].price
        )
      end
      session[:cart] = {}
      redirect_to root_path, notice: "Order placed successfully! Order ##{order.id}"
    else
      render :show, alert: "Something went wrong. Please try again."
    end
  end

  private

  def ensure_cart_not_empty
    if session[:cart].blank?
      redirect_to products_path, alert: "Your cart is empty."
    end
  end

  def build_cart_items(cart)
    cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      { product: product, quantity: quantity, subtotal: product.price * quantity }
    end.compact
  end

  def calculate_taxes(subtotal, province)
    if province
      @gst = (subtotal * province.gst / 100).round(2)
      @pst = (subtotal * province.pst / 100).round(2)
      @hst = (subtotal * province.hst / 100).round(2)
    else
      @gst = @pst = @hst = 0
    end
  end
end