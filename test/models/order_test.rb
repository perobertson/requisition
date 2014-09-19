require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create an order" do
    assert_difference "Order.all.count", 1 do
      order = Order.new valid_order
      assert order.valid?, order.errors.messages
      assert order.save
    end
  end

  test "must contain order items" do
    order = Order.new valid_order.except! :order_items_attributes
    assert !order.valid?
  end

  test "must specify character name" do
    order = Order.new valid_order.except! :character_name
    assert !order.valid?
  end

  private

    def valid_order
      {
        character_name: "Gandhi",
        order_items_attributes: [{
          item_id: items(:naglfar).id,
          quantity: 1
        }]
      }
    end

end
