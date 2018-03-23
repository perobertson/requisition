# frozen_string_literal: true

class ClearOldUsers < ActiveRecord::Migration[4.2]
  def change
    UserAbility.all.delete_all
    OrderItem.all.delete_all
    Order.all.delete_all
    User.all.delete_all
  end
end
