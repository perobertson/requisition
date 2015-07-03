require 'test_helper'

module Api
  class ItemsControllerTest < ActionController::TestCase
    describe 'order api tests' do
      let(:category) { categories(:category_drone) }
      let(:item) { items(:naglfar) }

      before do
        switch_login users(:user1)
      end

      it 'must create a new item' do
        request_body = {
          format: :json,
          item: {
            category_id: category.id,
            type_id: Random.rand(100),
            name: 'New Item',
            for_sale: 0
          }
        }
        post :create, request_body
        response.status.must_equal 201, response.body
        response_body = JSON.parse response.body
        item = Item.find response_body['id']

        item.category_id.must_equal request_body[:item][:category_id]
        item.type.wont_be_nil
        item.type_id.must_equal request_body[:item][:type_id]
        item.name.must_equal request_body[:item][:name]
        item.for_sale.must_equal false
      end

      it 'must change the items category' do
        category_id = Category.not_deleted.ids.delete_if { |id| id == item.category_id }.sample

        request_body = {
          format: :json,
          id: item.id,
          item: {
            category_id: category_id
          }
        }
        put :update, request_body
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
        put :update, request_body
        response.status.must_equal 204, response.body

        item.reload
        item.for_sale.must_equal(request_body[:item][:for_sale] == 1)
      end
    end
  end
end
