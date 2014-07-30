class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.timestamps
      t.datetime :deleted_at
      t.string :character_name, null: false
      t.integer :ship_id, null: false

      t.index :ship_id
      t.foreign_key :ships
    end
  end

  def down
    drop_table :orders
  end
end
