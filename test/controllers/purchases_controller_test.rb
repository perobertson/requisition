# frozen_string_literal: true
require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  describe 'unauthenticated' do
    describe 'index' do
      it 'must get the main page' do
        get :index
        assert_response :success
      end
    end
  end

  describe 'authenticated' do
    describe 'unauthorized' do
      before do
        switch_login users(:user1)
        @current_user.user_abilities.destroy_all
      end

      describe 'index' do
        it 'must get index' do
          get :index
          assert_response :success
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
