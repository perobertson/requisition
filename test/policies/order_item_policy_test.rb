require 'test_helper'

class OrderItemPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { OrderItemPolicy.new user, order_item }

  let(:user) { users(:user_no_abilities) }
  let(:order) { Order.new }
  let(:order_item) { OrderItem.new order: order }

  def test_scope
    OrderItemPolicy::Scope.new(user, OrderItem).resolve.count.must_equal OrderItem.none.count

    user = users(:user1)
    expected_count = user.orders.map(&:order_items).flatten.count
    OrderItemPolicy::Scope.new(user, OrderItem).resolve.count.must_equal expected_count
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
      user_with_abilities user, Ability.KINDS
      subject.show?.must_equal false
    end

    it 'must allow create' do
      user_with_abilities user, %i(place_order)
      subject.create?.must_equal true
    end

    it 'must not allow update' do
      user_with_abilities user, Ability.KINDS
      subject.update?.must_equal false
    end

    it 'must not allow destroy' do
      user_with_abilities user, Ability.KINDS
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
