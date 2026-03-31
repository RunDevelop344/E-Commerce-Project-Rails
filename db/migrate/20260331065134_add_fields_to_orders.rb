class AddFieldsToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :status, :string
    add_column :orders, :subtotal, :decimal
    add_column :orders, :gst_amount, :decimal
    add_column :orders, :pst_amount, :decimal
    add_column :orders, :hst_amount, :decimal
    add_column :orders, :province_id, :integer
    add_column :orders, :stripe_payment_id, :string
  end
end
