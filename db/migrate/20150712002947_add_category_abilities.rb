class AddCategoryAbilities < ActiveRecord::Migration
  def up
    Ability.create! kind: :view_category
    Ability.create! kind: :change_category
    Ability.create! kind: :add_category
  end

  def down
    kinds = %i[view_category change_category add_category]
    Ability.where(kind: kinds).each(&:destroy)
  end
end
