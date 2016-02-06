require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { user }
  let(:user) { users(:user_no_abilities) }
  let(:ability_place_order) { abilities(:ability_place_order) }

  describe 'Sanity' do
    let(:user) { User.new valid_user }

    it 'must start with valid fixtures' do
      User.all.each do |user|
        user.valid?.must_equal true, user.errors.messages
      end
    end

    it 'must create a valid user' do
      subject.valid?.must_equal true, subject.errors.messages
      subject.skip_confirmation!
      subject.save!
    end
  end

  describe 'defaults' do
    it 'must grant new users the place order ability' do
      user = User.new valid_user
      user.skip_confirmation!
      user.user_abilities.wont_be_empty
      abilities = user.user_abilities.select { |user_ability| user_ability.ability == ability_place_order }
      abilities.length.must_equal 1
      abilities.first.ability.must_equal ability_place_order
      abilities.first.deleted_at.must_be_nil
      user.save!
      user.reload
      user.can_place_order?.must_equal true
    end
  end

  describe 'has_ability?' do
    it 'must return true if the user has the ability' do
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        subject.user_abilities.create! ability: ability
        subject.has_ability?(kind).must_equal true
      end
    end

    it 'must return false if the user does not have the ability' do
      Ability.KINDS.each do |kind|
        subject.has_ability?(kind).must_equal false
      end
    end

    it 'must return false if the user has the ability has been removed' do
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        subject.user_abilities.create! ability: ability, deleted_at: Time.current
        subject.has_ability?(kind).must_equal false, "Failed on #{kind}"
      end
    end
  end

  describe 'dynamic helpers' do
    it 'must return true if the user has the ability' do
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        subject.user_abilities.create! ability: ability
        subject.send('can_' + kind.to_s + '?').must_equal true, "Failed on #{kind}"
      end
    end

    it 'must return false if the user does not have the ability' do
      Ability.KINDS.each do |kind|
        subject.send('can_' + kind.to_s + '?').must_equal false, "Failed on #{kind}"
      end
    end

    it 'must return false if the user has the ability has been removed' do
      Ability.KINDS.each do |kind|
        ability = Ability.find_by_kind kind
        subject.user_abilities.create! ability: ability, deleted_at: Time.current
        subject.send('can_' + kind.to_s + '?').must_equal false, "Failed on #{kind}"
      end
    end
  end

  def valid_user attributes_to_delete = nil
    {
      name: 'New User',
      email: 'new_user@gmail.com',
      password: 'password10'
    }.except!(*attributes_to_delete)
  end
end
