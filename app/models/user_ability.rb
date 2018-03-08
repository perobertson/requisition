class UserAbility < ApplicationRecord
  # Associations
  belongs_to :user, inverse_of: :user_abilities
  belongs_to :ability

  # Validations
  validates :user,      presence: true
  validates :ability,   presence: true

  validates :ability,   uniqueness: { scope: [:user] }
end
