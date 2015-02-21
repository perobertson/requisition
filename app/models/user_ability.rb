class UserAbility < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :ability

  # Scopes
  scope :deleted,      -> { where.not(deleted_at: nil) }
  scope :not_deleted,  -> { where(deleted_at: nil) }

  # Validations
  validates :user,      presence: true
  validates :ability,   presence: true

  validates :ability,   uniqueness: { scope: [:user, :deleted_at] }
end
