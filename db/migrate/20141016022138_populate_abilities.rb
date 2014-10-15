class PopulateAbilities < ActiveRecord::Migration
  def up
    Ability::KINDS.each do |kind|
      Ability.create! kind: kind unless Ability.where(kind: kind).any?
    end

    # Grant the place_order ability to all existing users
    place_order_ability = Ability.where(kind: :place_order).first
    User.all.each do |user|
      user.user_abilities.create! ability: place_order_ability
    end
  end

  def down
    UserAbility.all.each do |user_ability|
      user_ability.destroy!
    end

    Ability.all.each do |ability|
      ability.destroy!
    end
  end
end
