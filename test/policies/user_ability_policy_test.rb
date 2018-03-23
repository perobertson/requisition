# frozen_string_literal: true

require 'test_helper'

class UserAbilityPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { UserAbilityPolicy.new user, ability }

  let(:user) { users(:user_no_abilities) }
  let(:ability) { Ability.new }
  let(:other_user) { User.new }

  def test_scope
    UserAbilityPolicy::Scope.new(user, UserAbility).resolve.count.must_equal UserAbility.none.count

    user_with_abilities user, %i[view_users]
    UserAbilityPolicy::Scope.new(user, UserAbility).resolve.count.must_equal UserAbility.all.count
  end

  describe 'no ability' do
    it 'must not allow show' do
      subject.show?.must_equal false
    end

    it 'must not allow create' do
      subject.create?.must_equal false
    end

    it 'must not allow update' do
      subject.update?.must_equal false
    end

    it 'must not allow destroy' do
      subject.destroy?.must_equal false
    end
  end

  describe 'has ability' do
    it 'must allow show' do
      user_with_abilities user, %i[view_users]
      subject.show?.must_equal true
    end

    it 'must allow create' do
      user_with_abilities user, %i[change_user]
      subject.create?.must_equal true
    end

    it 'must not allow update' do
      user_with_abilities user, Ability.KINDS
      subject.update?.must_equal false
    end

    it 'must allow destroy' do
      user_with_abilities user, %i[change_user]
      subject.destroy?.must_equal true
    end
  end
end
