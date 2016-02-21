class RemoveDeletedAtFromOrders < ActiveRecord::Migration
  def up
    Order.where.not(deleted_at: nil).destroy_all
    remove_column :orders, :deleted_at
  end

  def down
    add_column :orders, :deleted_at, :datetime
  end
end
