class AddShippingToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipping, :float
  end
end
