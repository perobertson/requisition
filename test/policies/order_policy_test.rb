# frozen_string_literal: true

require 'test_helper'

class OrderPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { OrderPolicy.new user, order }

  let(:user) { users(:user_no_abilities) }
  let(:order) { Order.new }

  def test_scope
    OrderPolicy::Scope.new(user, Order).resolve.count.must_equal Order.none.count

    user = users(:user1)
    user.orders.wont_be_empty
    OrderPolicy::Scope.new(user, Order).resolve.count.must_equal user.orders.count
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
    it 'must not allow show' do
      user_with_abilities user, Ability.kinds
      subject.show?.must_equal false
    end

    it 'must allow create' do
      user_with_abilities user, %i[place_order]
      subject.create?.must_equal true
    end

    it 'must not allow update' do
      user_with_abilities user, Ability.kinds
      subject.update?.must_equal false
    end

    it 'must not allow destroy' do
      user_with_abilities user, Ability.kinds
      subject.destroy?.must_equal false
    end
  end

  describe 'personal orders' do
    it 'must allow show' do
      order.user = user
      subject.show?.must_equal true
    end
  end
end
