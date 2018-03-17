# frozen_string_literal: true
require 'test_helper'

class AbilityPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { AbilityPolicy.new user, ability }

  let(:user) { users(:user_no_abilities) }
  let(:ability) { Ability.new }

  def test_scope
    AbilityPolicy::Scope.new(user, Ability).resolve.count.must_equal Ability.none.count

    user_with_abilities user, %i[view_users]
    AbilityPolicy::Scope.new(user, Ability).resolve.count.must_equal Ability.all.count
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
      subject.create?.must_equal false
    end

    it 'must allow update' do
      subject.update?.must_equal false
    end

    it 'must not allow destroy' do
      subject.destroy?.must_equal false
    end
  end
end
