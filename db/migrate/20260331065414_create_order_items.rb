class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end
