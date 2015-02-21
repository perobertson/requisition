class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Associations
  has_many :user_abilities

  def has_ability?(kind)
    user_abilities.not_deleted.joins(:ability).where(abilities: { kind: kind }).any?
  end

  # Ability helper methods 'can_ability_kind?'
  Ability.KINDS.each do |kind|
    define_method('can_' + kind.to_s + '?') do
      has_ability? kind
    end
  end
end
