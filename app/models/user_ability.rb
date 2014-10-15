class UserAbility < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :ability

  # Validations
  validates :user,      presence: true
  validates :ability,   presence: true

  validates :ability,   uniqueness: { scope: [:user, :deleted_at] }
end
