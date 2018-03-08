class EnforceIntegrity < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :items, :categories

    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :items

    add_foreign_key :user_abilities, :abilities
    add_foreign_key :user_abilities, :users
  end
end
