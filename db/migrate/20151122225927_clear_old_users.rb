class ClearOldUsers < ActiveRecord::Migration
  def change
    UserAbility.all.delete_all
    OrderItem.all.delete_all
    Order.all.delete_all
    User.all.delete_all
  end
end
