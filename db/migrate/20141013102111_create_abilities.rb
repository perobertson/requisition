class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.timestamps null: false
      t.datetime :deleted_at

      t.string :kind,         null: false

      t.index :kind,          unique: true
    end
  end
end
