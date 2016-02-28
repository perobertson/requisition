require 'test_helper'

module Api
  class OrdersControllerTest < ActionController::TestCase
    describe 'order api tests' do
      let(:naglfar) { items(:naglfar) }
      let(:expected_keys) { %w(id created_at updated_at user_id).sort }

      before do
        switch_login users(:user1)
      end

      it 'must list the orders' do
        get :index, format: :json
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body['orders'].length.must_equal @current_user.orders.count
        response_body['orders'].first.keys.sort.must_equal expected_keys

        response_body['orders'].each do |order_json|
          verify_json Order, order_json, expected_keys
        end
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
        post :create, request_body
        response.status.must_equal 201
        response_body = JSON.parse response.body

        order = Order.find response_body['id']
        order.user.must_equal @current_user
        order.order_items.count.must_equal request_body[:order][:order_items_attributes].count
        order.order_items.each do |order_item|
          order_item.item.must_equal naglfar
          order_item.quantity.must_equal 1
        end

        get :show, format: :json, id: response_body['id']
        response.status.must_equal 200
        show_body = JSON.parse response.body
        response_body.must_equal show_body
      end
    end
  end
end
