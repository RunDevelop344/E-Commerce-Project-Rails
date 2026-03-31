class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items
  has_many :products, through: :order_items

  enum :status, { new_order: "new", paid: "paid", shipped: "shipped" }

  def grand_total
    subtotal.to_f + gst_amount.to_f + pst_amount.to_f + hst_amount.to_f
  end
end