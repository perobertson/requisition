class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Associations
  has_many :abilities, through: :user_abilities
  has_many :user_abilities

  # Ability helper methods 'can_ability_kind?'
  Ability.KINDS.each do |kind|
    define_method('can_' + kind.to_s.downcase.gsub('.', '').gsub(' ', '_') + '?') do
      abilities.where(kind: kind).any?
    end
  end
end
