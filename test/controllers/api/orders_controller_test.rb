require 'test_helper'

describe Api::OrdersController do
  before do
  end
  after do
  end

  describe "order api tests" do

    before do
      switch_login users(:user1)
    end

    it "must create orders" do
      request_body = {
        format: :json,
        order: {
          character_name: "Gandhi",
          order_items_attributes: [
            item_id: items(:naglfar).id,
            quantity: 1
          ]
        }
      }
      post :create, request_body, format: :json
      response.status.must_equal 201
      response_body = JSON.parse(response.body)
      order = Order.find_by_id response_body["id"]
      order.wont_be_nil
      order.character_name.must_equal request_body[:order][:character_name]
      order.order_items.count.must_equal request_body[:order][:order_items_attributes].count
      # TODO check each item
    end
  end
end
