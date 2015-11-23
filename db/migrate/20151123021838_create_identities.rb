class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps null: false
    end
  end
end
