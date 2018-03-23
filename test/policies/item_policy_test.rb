# frozen_string_literal: true

require 'test_helper'

class ItemPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { ItemPolicy.new user, item }

  let(:user) { users(:user_no_abilities) }
  let(:item) { Item.new }

  def test_scope
    ItemPolicy::Scope.new(user, Item).resolve.count.must_equal Item.for_sale.count

    user_with_abilities user, %i[view_inventory]
    ItemPolicy::Scope.new(user, Item).resolve.count.must_equal Item.all.count
  end

  describe 'no ability' do
    it 'must allow show for all for sale items' do
      item = Item.new for_sale: true
      subject = ItemPolicy.new user, item
      subject.show?.must_equal true
    end

    it 'must not allow show for non sale items' do
      item = Item.new for_sale: false
      subject = ItemPolicy.new user, item
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
    it 'must allow show for all for sale items' do
      item = Item.new for_sale: true
      subject = ItemPolicy.new user, item
      subject.show?.must_equal true
    end

    it 'must allow show for non for sale items' do
      user_with_abilities user, %i[view_inventory]
      item = Item.new for_sale: false
      subject = ItemPolicy.new user, item
      subject.show?.must_equal true
    end

    it 'must allow create' do
      user_with_abilities user, %i[add_inventory]
      subject.create?.must_equal true
    end

    it 'must allow update' do
      user_with_abilities user, %i[change_inventory]
      subject.update?.must_equal true
    end

    it 'must not allow destroy' do
      user_with_abilities user, Ability.kinds
      subject.destroy?.must_equal false
    end
  end
end
