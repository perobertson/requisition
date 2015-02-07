ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/ci'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  # use the devise test helpers for controller tests
  include Devise::TestHelpers

  def teardown
    switch_login nil
    super
  end

  def switch_login(user)
    sign_out @current_user if @current_user.present?
    @current_user = user
    if @current_user
      @current_user.confirm!
      sign_in @current_user
    end
  end
end
