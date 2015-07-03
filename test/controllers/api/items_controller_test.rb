require 'test_helper'

module Api
  class ItemsControllerTest < ActionController::TestCase
    describe 'order api tests' do
      let(:category) { categories(:category_drone) }

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
    end
  end
end
