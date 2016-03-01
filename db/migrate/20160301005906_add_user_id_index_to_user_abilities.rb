class AddUserIdIndexToUserAbilities < ActiveRecord::Migration
  def change
    add_index :user_abilities, :user_id
  end
end
