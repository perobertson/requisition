class CreateItems < ActiveRecord::Migration
  def change
    # Create the STI for the items
    create_table :items do |t|
      t.timestamps
      t.datetime :deleted_at
      t.string :type,           null: false
      t.integer :type_id,       null: false
      t.string :name,           null: false

      t.index :type_id,         unique: true
    end
  end
end
