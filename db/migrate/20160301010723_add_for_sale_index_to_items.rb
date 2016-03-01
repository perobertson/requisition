class AddForSaleIndexToItems < ActiveRecord::Migration
  def change
    add_index :items, :for_sale
  end
end
