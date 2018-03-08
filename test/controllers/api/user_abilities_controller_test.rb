require 'test_helper'

module Api
  class UserAbilitiesControllerTest < ActionController::TestCase
    let(:user) { users(:user_jimmy) }
    let(:ability_place_order) { abilities(:ability_place_order) }
    let(:ability_view_inventory) { abilities(:ability_view_inventory) }

    describe 'user abilities api tests' do
      before do
        switch_login users(:user1)
      end

      it 'must add an ability to a user' do
        request_body = {
          format: :json,
          user_id: user.id,
          user_ability: {
            ability_id: ability_view_inventory.id
          }
        }
        post :create, params: request_body
        response.status.must_equal 201, response.body
        response_body = JSON.parse response.body
        user_ability = UserAbility.find response_body['id']

        user_ability.user_id.must_equal request_body[:user_id]
        user_ability.ability_id.must_equal request_body[:user_ability][:ability_id]
      end

      it 'must not allow for the same ability to be added multiple times' do
        request_body = {
          format: :json,
          user_id: user.id,
          user_ability: {
            ability_id: ability_place_order.id
          }
        }
        post :create, params: request_body
        response.status.must_equal 422, response.body
        response_body = JSON.parse response.body
        response_body['errors'].first['error']['field'].must_equal 'ability'
      end

      it 'must remove an ability from a user' do
        user_ability = user.user_abilities.where(ability: ability_place_order).first
        user_ability.wont_be_nil

        request_body = {
          format: :json,
          id: user_ability.id
        }
        Timecop.freeze do
          delete :destroy, params: request_body
          response.status.must_equal 204, response.body
          UserAbility.find_by_id(user_ability.id).must_be_nil
        end
      end
    end

    describe 'no abilities' do
      before do
        switch_login users(:user_no_abilities)
      end

      it 'must not be able to list abilities for a user' do
        skip 'no route to list abilities on a user'
      end

      it 'must not be able to create a user ability' do
        post :create, params: { format: :json, user_id: @current_user.id, user_ability: { kind: 'change_user' } }
        response.status.must_equal 403
      end

      it 'must not be able to destroy a user ability' do
        delete :destroy, params: { format: :json, id: UserAbility.first.id }
        response.status.must_equal 404
      end
    end
  end
end
