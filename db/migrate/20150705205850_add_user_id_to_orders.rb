class AddUserIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer, null: false
    add_foreign_key :orders, :users
  end
end
