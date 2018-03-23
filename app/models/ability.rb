# frozen_string_literal: true

class Ability < ApplicationRecord
  # Constants
  @@KINDS = [
    :place_order,
    :view_inventory, :change_inventory, :add_inventory,
    :view_users, :change_user,
    :view_category, :change_category, :add_category
  ].freeze
  cattr_reader :KINDS

  # Validations
  validates :kind, inclusion:  @@KINDS.map(&:to_s)
  validates :kind, uniqueness: true

  def self.create_missing!
    @@KINDS.each do |kind|
      create! kind: kind unless Ability.where(kind: kind).any?
    end
  end
end
