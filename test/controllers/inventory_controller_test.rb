require 'test_helper'

describe InventoryController do
  describe 'unauthenticated' do
    describe 'index' do
      it 'must be redirected to login' do
        get :index
        response.status.must_equal 302
      end
    end
  end

  describe 'authenticated' do
    describe 'unauthorized' do
      before do
        switch_login users(:user1)
        @current_user.user_abilities.not_deleted.update_all deleted_at: Time.current
      end

      describe 'index' do
        it 'must get index' do
          get :index
          assert_response :see_other
        end
      end
    end

    describe 'authorized' do
      before do
        switch_login users(:user1)
      end

      describe 'index' do
        it 'must get index' do
          get :index
          assert_response :success
        end
      end
    end
  end
end
