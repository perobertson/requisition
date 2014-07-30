require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create an order" do
    assert_difference "Order.all.count", 1 do
      Order.create(character_name: "Gandhi", ship: ships(:naglfar))
    end
  end
end
