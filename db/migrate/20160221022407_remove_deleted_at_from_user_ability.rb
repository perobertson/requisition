# frozen_string_literal: true

class RemoveDeletedAtFromUserAbility < ActiveRecord::Migration[4.2]
  def up
    UserAbility.where.not(deleted_at: nil).destroy_all
    remove_column :user_abilities, :deleted_at
  end

  def down
    add_column :user_abilities, :deleted_at, :datetime
    add_index :user_abilities, %i[user_id ability_id deleted_at], unique: true
  end
end
