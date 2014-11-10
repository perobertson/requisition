class Category < ActiveRecord::Base

  # Scopes
  scope :deleted,      -> { where.not(deleted_at: nil) }
  scope :not_deleted,  -> { where(deleted_at: nil) }

  # Associations
  has_many :items

  # Validations
  validates :name,      presence: true
  validates :name,      uniqueness: true

  def self.names
    Category.not_deleted.pluck(:name)
  end
end
