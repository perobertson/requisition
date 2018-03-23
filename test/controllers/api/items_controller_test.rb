# frozen_string_literal: true

require 'test_helper'

module Api
  class ItemsControllerTest < ActionController::TestCase
    let(:expected_keys) { %w[id created_at updated_at deleted_at type_id name for_sale category_id rendered].sort }

    describe 'item api tests' do
      let(:category) { categories(:category_drone) }
      let(:item) { items(:naglfar) }

      before do
        switch_login users(:user1)
      end

      it 'must list the items' do
        get :index, format: :json
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body['items'].length.must_equal Item.all.count
        response_body['items'].first.keys.sort.must_equal expected_keys

        response_body['items'].each do |item_json|
          verify_json Item, item_json, expected_keys
        end
      end

      it 'must show an item' do
        get :show, params: { format: :json, id: Item.not_for_sale.first.id }
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body.keys.sort.must_equal expected_keys
        verify_json Item, response_body, expected_keys
      end

      it 'must create a new item' do
        request_body = {
          format: :json,
          item: {
            category_id: category.id,
            type_id: Random.rand(100) + 1,
            name: 'New Item',
            for_sale: false,
            rendered: true
          }
        }
        post :create, params: request_body
        response.status.must_equal 201, response.body
        response_body = JSON.parse response.body
        verify_json_create Item, request_body[:item], response_body['id']

        get :show, params: { format: :json, id: response_body['id'] }
        response.status.must_equal 200
        show_body = JSON.parse response.body
        response_body.must_equal show_body
      end

      it 'must change the items category' do
        category_id = Category.ids.delete_if { |id| id == item.category_id }.sample

        request_body = {
          format: :json,
          id: item.id,
          item: {
            category_id: category_id
          }
        }
        put :update, params: request_body
        response.status.must_equal 204, response.body

        updated_item = Item.find item.id
        updated_item.category_id.must_equal request_body[:item][:category_id]
      end

      it 'must change the items for sale status' do
        for_sale = item.for_sale ? 0 : 1

        request_body = {
          format: :json,
          id: item.id,
          item: {
            for_sale: for_sale
          }
        }
        put :update, params: request_body
        response.status.must_equal 204, response.body

        item.reload
        item.for_sale.must_equal(request_body[:item][:for_sale] == 1)
      end
    end

    describe 'no abilities' do
      before do
        switch_login users(:user_no_abilities)
      end

      it 'must be able to list items for sale' do
        get :index, format: :json
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body['items'].length.must_equal Item.for_sale.count
        response_body['items'].first.keys.sort.must_equal expected_keys

        response_body['items'].each do |item_json|
          verify_json Item, item_json, expected_keys
        end
      end

      it 'must be able to show an item that is for sale' do
        get :show, params: { format: :json, id: Item.for_sale.first.id }
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body.keys.sort.must_equal expected_keys
        verify_json Item, response_body, expected_keys
      end

      it 'must not be able to show an item that is not for sale' do
        get :show, params: { format: :json, id: Item.not_for_sale.first.id }
        response.status.must_equal 404
      end

      it 'must not be able to create an item' do
        post :create, params: { format: :json, item: { name: 'test' } }
        response.status.must_equal 403
      end

      it 'must not be able to update an item' do
        patch :update, params: { format: :json, id: Item.not_for_sale.first.id, name: 'test' }
        response.status.must_equal 404
      end
    end
  end
end
