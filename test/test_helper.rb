ENV['RAILS_ENV'] ||= 'test'
ENV['REQUISITION_MAILER_ACCOUNT'] ||= "public.relations@email.com"
ENV['REQUISITION_BUILDER_EMAIL']  ||= "ship.builder@email.com"

if ENV["NO_COVERAGE"] != "1"
  require 'simplecov'

  if ENV['CIRCLE_ARTIFACTS']
    dir = File.join("..", "..", "..", ENV['CIRCLE_ARTIFACTS'], "coverage")
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start do
    add_group "Models", "app/models"
    add_group "Controllers", "app/controllers"
    add_group "Helpers", "app/helpers"
    add_group "Policies", "app/policies"
    add_group "Configuration", "config/"
    add_group "Libraries", "lib/"
    add_group "Test Files", "test/"

    add_group "Long files" do |src_file|
      src_file.lines.count > 250
    end

    # get rid of bundled rails/ruby code
    add_filter "vendor/bundle"

    # make sure we get all results since our tests can take a while
    merge_timeout 60 * 30
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

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
