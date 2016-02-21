class RemoveDeletedAtFromAbility < ActiveRecord::Migration
  def up
    Ability.where.not(deleted_at: nil).destroy_all
    remove_column :abilities, :deleted_at
  end

  def down
    add_column :abilities, :deleted_at, :datetime
  end
end
