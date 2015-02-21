class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.timestamps
      t.datetime :deleted_at
      t.integer :order_id,      null: false
      t.integer :item_id,       null: false
      t.integer :quantity,      null: false

      t.index :order_id
      t.foreign_key :orders

      t.index :item_id
      t.foreign_key :items
    end
  end
end
