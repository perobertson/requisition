class RemoveCharacterNameFromOrders < ActiveRecord::Migration[4.2]
  def up
    remove_column :orders, :character_name, :string, null: false
  end

  def down
    add_column :orders, :character_name, :string
    Order.all.each do |order|
      order.update_columns character_name: order.user.name
    end
    change_column_null :orders, :character_name, false
  end
end
