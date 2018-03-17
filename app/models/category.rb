# frozen_string_literal: true
class Category < ApplicationRecord
  # Associations
  has_many :items

  # Validations
  validates :name,      presence: true
  validates :name,      uniqueness: true
  before_destroy :check_for_items

  def self.names
    Category.order(:name).pluck(:name)
  end

  def self.names_for_select
    Category.order(:name).pluck(:name, :id)
  end

private

  def check_for_items
    if items.empty?
      return
    end
    errors.add :base, 'cannot be destroyed while category has items in it'
    throw :abort
  end
end
