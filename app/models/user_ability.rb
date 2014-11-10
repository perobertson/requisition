class UserAbility < ActiveRecord::Base
  # Scopes
  scope :deleted,      -> { where.not(deleted_at: nil) }
  scope :not_deleted,  -> { where(deleted_at: nil) }

  # Associations
  belongs_to :user
  belongs_to :ability

  # Validations
  validates :user,      presence: true
  validates :ability,   presence: true

  validates :ability,   uniqueness: { scope: [:user, :deleted_at] }
end
