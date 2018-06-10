# frozen_string_literal: true

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
      user.save!
      user.reload
      user.can_place_order?.must_equal true
    end

    it 'must grant the first user all the abilities' do
      OrderItem.all.delete_all
      Order.all.delete_all
      UserAbility.all.delete_all
      User.all.delete_all

      user = User.new valid_user
      user.skip_confirmation!
      user.user_abilities.wont_be_empty
      user.user_abilities.length.must_equal Ability.count
      user.save!
      user.reload

      Ability.all.each do |ability|
        user.ability?(ability.kind).must_equal true
      end
    end
  end

  describe 'ability?' do
    it 'must return true if the user has the ability' do
      Ability.kinds.each do |kind|
        ability = Ability.find_by kind: kind
        subject.user_abilities.create! ability: ability
        subject.ability?(kind).must_equal true
      end
    end

    it 'must return false if the user does not have the ability' do
      Ability.kinds.each do |kind|
        subject.ability?(kind).must_equal false
      end
    end
  end

  describe 'dynamic helpers' do
    it 'must return true if the user has the ability' do
      Ability.kinds.each do |kind|
        ability = Ability.find_by kind: kind
        subject.user_abilities.create! ability: ability
        subject.send('can_' + kind.to_s + '?').must_equal true, "Failed on #{kind}"
      end
    end

    it 'must return false if the user does not have the ability' do
      Ability.kinds.each do |kind|
        subject.send('can_' + kind.to_s + '?').must_equal false, "Failed on #{kind}"
      end
    end
  end

  def valid_user(attributes_to_delete = nil)
    {
      name: 'New User',
      email: 'new_user@gmail.com'
    }.except!(*attributes_to_delete)
  end
end
