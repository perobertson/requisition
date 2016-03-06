require 'test_helper'

module Api
  class UsersControllerTest < ActionController::TestCase
    let(:expected_keys) { %w(id created_at updated_at name).sort }

    describe 'user api tests' do
      before do
        switch_login users(:user1)
      end

      it 'must list the users' do
        get :index, format: :json
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body['users'].length.must_equal User.all.count
        response_body['users'].first.keys.sort.must_equal expected_keys

        response_body['users'].each do |user_json|
          verify_json User, user_json, expected_keys
        end
      end

      it 'must show a user' do
        get :show, format: :json, id: User.first.id
        response.status.must_equal 200
        response_body = JSON.parse response.body

        response_body.keys.sort.must_equal expected_keys
        verify_json User, response_body, expected_keys
      end

      it 'must update a users email' do
        request_body = {
          format: :json,
          id: @current_user.id,
          user: {
            email: "#{SecureRandom.uuid}@email.com"
          }
        }
        put :update, request_body
        response.status.must_equal 204, response.body

        @current_user.reload
        @current_user.unconfirmed_email.must_equal request_body[:user][:email]
      end
    end
  end
end
