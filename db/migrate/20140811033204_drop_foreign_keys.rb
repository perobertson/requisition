class DropForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :order_items, :items
    remove_foreign_key :order_items, :orders
  end
end
