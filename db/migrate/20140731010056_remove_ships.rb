class RemoveShips < ActiveRecord::Migration
  def change
    Order.all.each(&:destroy!)
    remove_column :orders, :ship_id
    drop_table :ships

    add_column :orders, :item_id, :integer, null: false
    add_index :orders, :item_id
    add_foreign_key :orders, :items
  end
end
