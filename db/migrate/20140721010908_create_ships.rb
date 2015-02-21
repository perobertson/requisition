class CreateShips < ActiveRecord::Migration
  def up
    create_table :ships do |t|
      t.timestamps
      t.string :name,       null: false
      t.text :description,  null: false
    end
  end

  def down
    drop_table :ships
  end
end
