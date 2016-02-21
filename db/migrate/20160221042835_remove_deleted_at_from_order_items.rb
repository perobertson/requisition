class RemoveDeletedAtFromOrderItems < ActiveRecord::Migration
  def up
    OrderItem.where.not(deleted_at: nil).destroy_all
    remove_column :order_items, :deleted_at
  end

  def down
    add_column :order_items, :deleted_at, :datetime
  end
end
