class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items
  has_many :products, through: :order_items

  enum :status, { new_order: "new", paid: "paid", shipped: "shipped" }

  validates :status, presence: true
  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_amount, numericality: { greater_than_or_equal_to: 0 }

  def grand_total
    subtotal.to_f + gst_amount.to_f + pst_amount.to_f + hst_amount.to_f
  end
end
