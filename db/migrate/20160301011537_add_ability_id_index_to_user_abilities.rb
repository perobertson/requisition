class AddAbilityIdIndexToUserAbilities < ActiveRecord::Migration
  def change
    add_index :user_abilities, :ability_id
  end
end
