# frozen_string_literal: true

class AddRenderedToItems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :rendered, :boolean

    # Currently all items that have been entered use rendered images
    Item.all.update_all rendered: true
    change_column_null :items, :rendered, false
  end
end
