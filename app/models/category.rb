class Category < ActiveRecord::Base
  include SoftDeletable

  # Associations
  has_many :items

  # Validations
  validates :name,      presence: true
  validates :name,      uniqueness: true
  validate :validate_category

  def self.names
    Category.not_deleted.order(:name).pluck(:name)
  end

  def self.names_for_select
    Category.not_deleted.order(:name).pluck(:name, :id)
  end

private

  def validate_category
    if errors.any?
      return false
    end

    if deleted_at.present? && !items.empty?
      errors.add :deleted_at, 'cannot be present while category has items in it'
      return false
    end
  end
end
