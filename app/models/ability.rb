class Ability < ActiveRecord::Base

  # Constants
  @@KINDS = [
    :place_order,
    :view_inventory, :change_inventory, :add_inventory,
    :view_users, :change_user,
  ].freeze
  cattr_reader :KINDS

  # Validations
  validates :kind, inclusion:  @@KINDS.map(&:to_s)
  validates :kind, uniqueness: true

end