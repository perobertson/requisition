require 'test_helper'

module Api
  class OrdersControllerTest < ActionController::TestCase
    describe 'order api tests' do
      let(:naglfar) { items(:naglfar) }
      before do
        switch_login users(:user1)
      end

      it 'must create orders' do
        request_body = {
          format: :json,
          order: {
            order_items_attributes: [
              item_id: naglfar.id,
              quantity: 1
            ]
          }
        }
        post :create, request_body, format: :json
        response.status.must_equal 201
        response_body = JSON.parse(response.body)
        order = Order.find response_body['id']
        order.user.must_equal @current_user
        order.order_items.count.must_equal request_body[:order][:order_items_attributes].count
        order.order_items.first.item do |item|
          item.must_equal naglfar
          item.quantity.must_equal 1
        end
      end
    end
  end
end
