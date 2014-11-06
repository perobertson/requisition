class AddForSaleToItem < ActiveRecord::Migration
  def up
    Item.transaction do
      add_column :items, :for_sale, :bool

      Item.update_all for_sale: false

      change_column_null :items, :for_sale, false
    end
  end
  def down
    remove_column :items, :for_sale
  end
end
