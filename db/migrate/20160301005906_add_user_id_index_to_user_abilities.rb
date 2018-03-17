# frozen_string_literal: true
class AddUserIdIndexToUserAbilities < ActiveRecord::Migration[4.2]
  def change
    add_index :user_abilities, :user_id
  end
end
