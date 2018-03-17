# frozen_string_literal: true
require 'test_helper'

class UserAbilityTest < ActiveSupport::TestCase
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      UserAbility.all.each do |user_ability|
        user_ability.valid?.must_equal true, user_ability.errors.messages
      end
    end
  end

  describe 'Validations' do
    before do
      UserAbility.all.each(&:destroy!)
    end

    it 'must create a valid user ability' do
      user_ability = UserAbility.create valid_user_ability
      user_ability.valid?.must_equal true, user_ability.errors.messages
    end

    it 'must not be able to create the same user ability multiple times' do
      user_ability = UserAbility.create valid_user_ability
      user_ability.valid?.must_equal true, user_ability.errors.messages

      user_ability = UserAbility.create valid_user_ability
      user_ability.valid?.must_equal false, 'Should have been invalid'
      user_ability.errors[:ability].wont_be_empty
    end
  end

  def valid_user_ability(attributes_to_delete = nil)
    {
      user_id: users(:user1).id,
      ability_id: abilities(:ability_place_order).id
    }.except!(*attributes_to_delete)
  end
end
