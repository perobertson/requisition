class AddUserIdIndexToOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :orders, :user_id
  end
end
