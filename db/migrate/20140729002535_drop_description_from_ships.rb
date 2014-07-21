class DropDescriptionFromShips < ActiveRecord::Migration
  def change
    remove_column :ships, :description
  end
end
