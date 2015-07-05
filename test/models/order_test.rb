require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Order.all.each do |ability|
        ability.valid?.must_equal true, ability.errors.messages
      end
    end
  end

  describe 'Validations' do
    it 'must create an order' do
      assert_difference 'Order.all.count', 1 do
        order = Order.new valid_order
        order.valid?.must_equal true, order.errors.messages
        order.save.must_equal true, 'Could not save order'
      end
    end

    it 'must contain order items' do
      order = Order.new valid_order.except! :order_items_attributes
      order.valid?.must_equal false, 'Order should require items'
    end

    it 'must specify character name' do
      order = Order.new valid_order.except! :character_name
      order.valid?.must_equal false, 'Order must have a character name'
    end
  end

private

  def valid_order
    {
      character_name: 'Gandhi',
      order_items_attributes: [{
        item_id: items(:naglfar).id,
        quantity: 1
      }]
    }
  end
end
