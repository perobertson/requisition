class AddAbilityIdIndexToUserAbilities < ActiveRecord::Migration[4.2]
  def change
    add_index :user_abilities, :ability_id
  end
end
