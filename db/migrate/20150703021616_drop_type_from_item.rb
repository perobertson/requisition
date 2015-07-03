class DropTypeFromItem < ActiveRecord::Migration
  def up
    remove_column :items, :type
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
