# frozen_string_literal: true

class AddForSaleIndexToItems < ActiveRecord::Migration[4.2]
  def change
    add_index :items, :for_sale
  end
end
