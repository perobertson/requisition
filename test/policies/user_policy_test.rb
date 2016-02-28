require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { UserPolicy.new user, other_user }

  let(:user) { users(:user_no_abilities) }
  let(:other_user) { User.new }

  def test_scope
    UserPolicy::Scope.new(user, User).resolve.count.must_equal User.none.count

    user_with_abilities user, %i(view_users)
    UserPolicy::Scope.new(user, User).resolve.count.must_equal User.all.count
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
      user_with_abilities user, %i(view_users)
      subject.show?.must_equal true
    end

    it 'must not allow create' do
      user_with_abilities user, Ability.KINDS
      subject.create?.must_equal false
    end

    it 'must not allow update' do
      user_with_abilities user, Ability.KINDS
      subject.update?.must_equal false
    end

    it 'must allow self update' do
      subject = UserPolicy.new user, user
      subject.update?.must_equal true
    end

    it 'must not allow destroy' do
      user_with_abilities user, Ability.KINDS
      subject.destroy?.must_equal false
    end
  end
end
