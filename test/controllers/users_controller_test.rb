# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  describe 'unauthenticated' do
    describe 'finish_signup' do
      it 'must be redirected to login' do
        get :finish_signup
        response.status.must_equal 302
        response.redirect_url.must_equal user_eve_online_omniauth_authorize_url
      end

      it 'must be redirected to login when updating' do
        patch :finish_signup, params: { user: { email: 'test@email.com' } }
        response.status.must_equal 302
        response.redirect_url.must_equal user_eve_online_omniauth_authorize_url
      end
    end
  end

  describe 'authenticated' do
    before do
      switch_login users :user1
    end

    it 'must render the finish login page' do
      get :finish_signup
      response.status.must_equal 200
    end

    it 'must be able to update the email and send a confirmation email' do
      patch :finish_signup, params: { user: { email: 'test@email.com' } }
      response.status.must_equal 302
      response.redirect_url.must_equal root_url

      mail = ActionMailer::Base.deliveries.last
      mail.wont_be_nil
      mail.subject.must_equal 'Confirmation instructions'
    end
  end
end
