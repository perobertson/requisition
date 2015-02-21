class AddTypeIdToShips < ActiveRecord::Migration
  def up
    add_column :ships, :type_id, :integer, null: false
    add_index :ships, :type_id
  end

  def down
    remove_index :ships, :type_id
    remove_column :ships, :type_id
  end
end
