class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Associations
  has_many :user_abilities, inverse_of: :user

  accepts_nested_attributes_for :user_abilities

  # Validations / Callbacks
  after_initialize :set_defaults, if: :new_record?

  def has_ability? kind
    user_abilities.not_deleted.joins(:ability).where(abilities: { kind: kind }).any?
  end

  # Ability helper methods 'can_ability_kind?'
  Ability.KINDS.each do |kind|
    define_method('can_' + kind.to_s + '?') do
      has_ability? kind
    end
  end

private

  def set_defaults
    if user_abilities.empty?
      place_order = Ability.not_deleted.where(kind: :place_order).first
      if place_order.present?
        user_abilities.new ability: place_order
      end
    end
  end
end
