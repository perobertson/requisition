# frozen_string_literal: true

class RemoveDeletedAtFromCategories < ActiveRecord::Migration[4.2]
  def up
    Category.where.not(deleted_at: nil).destroy_all
    remove_column :categories, :deleted_at
  end

  def down
    add_column :categories, :deleted_at, :datetime
  end
end
