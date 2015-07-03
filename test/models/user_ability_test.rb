require 'test_helper'

describe UserAbility do
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      UserAbility.all.each do |user_ability|
        user_ability.valid?.must_equal true, user_ability.errors.messages
      end
    end
  end

  describe 'Scopes' do
    it 'must properly scope deleted and not deleted entries' do
      deleted_count = UserAbility.deleted.count
      not_deleted_count = UserAbility.not_deleted.count
      UserAbility.count.must_equal deleted_count + not_deleted_count
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

    it 'must not be able to create the same user ability multiple times if it has been deleted' do
      user_ability = UserAbility.create valid_user_ability
      user_ability.valid?.must_equal true, user_ability.errors.messages

      2.times do
        user_ability = UserAbility.create valid_user_ability.merge! deleted_at: Time.current
        user_ability.valid?.must_equal true, user_ability.errors.messages
      end
    end
  end

  def valid_user_ability(attributes_to_delete = nil)
    {
      user_id: users(:user1).id,
      ability_id: abilities(:ability_place_order).id
    }.except!(*attributes_to_delete)
  end
end
