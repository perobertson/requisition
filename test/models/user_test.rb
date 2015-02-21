require 'test_helper'

describe User do
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      User.all.each do |user|
        user.valid?.must_equal true, user.errors.messages
      end
    end
  end

  describe 'has_ability?' do
    it 'must return true if the user has the ability' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        user.user_abilities.create! ability: ability
        user.has_ability?(kind).must_equal true
      end
    end

    it 'must return false if the user does not have the ability' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        user.has_ability?(kind).must_equal false
      end
    end

    it 'must return false if the user has the ability has been removed' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        user.user_abilities.create! ability: ability, deleted_at: Time.current
        user.has_ability?(kind).must_equal false, "Failed on #{kind}"
      end
    end
  end

  describe 'dynamic helpers' do
    it 'must return true if the user has the ability' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        user.user_abilities.create! ability: ability
        user.send('can_' + kind.to_s + '?').must_equal true, "Failed on #{kind}"
      end
    end

    it 'must return false if the user does not have the ability' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        user.send('can_' + kind.to_s + '?').must_equal false, "Failed on #{kind}"
      end
    end

    it 'must return false if the user has the ability has been removed' do
      user = User.create! valid_user
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        user.user_abilities.create! ability: ability, deleted_at: Time.current
        user.send('can_' + kind.to_s + '?').must_equal false, "Failed on #{kind}"
      end
    end
  end

  def valid_user(attributes_to_delete = nil)
    {
      email: 'new_user@gmail.com',
      password: 'password10'
    }.except!(*attributes_to_delete)
  end
end
