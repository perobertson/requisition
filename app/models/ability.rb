class Ability < ActiveRecord::Base

  # Constants
  KINDS = [:place_order, :view_inventory, :change_inventory, :add_inventory]

  # Associations
  has_many :users,          through: :user_abilities
  has_many :user_abilities

  # Validations
  validates :kind, inclusion:  KINDS.map(&:to_s)
  validates :kind, uniqueness: true

end
