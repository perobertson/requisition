class CreateUserAbilities < ActiveRecord::Migration
  def change
    create_table :user_abilities do |t|
      t.timestamps null: false
      t.datetime :deleted_at

      t.integer :user_id,     null: false
      t.integer :ability_id,  null: false

      t.index [:user_id, :ability_id, :deleted_at], unique: true
    end
  end
end
