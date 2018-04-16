# frozen_string_literal: true

class Ability < ApplicationRecord
  @kinds = %i[
    place_order
    view_inventory change_inventory add_inventory
    view_users change_user
    view_category change_category add_category
  ].freeze
  class << self
    attr_reader :kinds
  end

  # Validations
  validates :kind, inclusion:  @kinds.map(&:to_s)
  validates :kind, uniqueness: true

  def self.create_missing!
    @kinds.each do |kind|
      create! kind: kind unless Ability.where(kind: kind).any?
    end
  end
end
