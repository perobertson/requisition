# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
ENV['MAILER_FROM_EMAIL'] ||= 'public.relations@email.com'
ENV['REQUISITION_BUILDER_EMAIL'] ||= 'ship.builder@email.com'

require File.expand_path('../../config/environment', __FILE__)

require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start do
  command_name "requisition_#{ENV['CIRCLE_BUILD_NUM']}_#{ENV['CIRCLE_NODE_INDEX']}"

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Policies', 'app/policies'
  add_group 'Configuration', 'config/'
  add_group 'Libraries', 'lib/'
  add_group 'Test Files', 'test/'

  add_group 'Long files' do |src_file|
    src_file.lines.count > 250
  end

  # get rid of bundled rails/ruby code
  add_filter 'vendor/bundle'

  # make sure we get all results since our tests can take a while
  merge_timeout 60 * 30
end

require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def setup
      Rails.cache.clear
    end
  end
end

module ActionController
  class TestCase
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
        @current_user.confirm
        sign_in @current_user
      end
    end

    def verify_json(table, json, expected_keys)
      json.keys.sort.must_equal expected_keys
      resource = table.find json['id']
      json.keys.each do |key|
        if resource[key].nil?
          json[key].must_be_nil
        elsif resource[key].respond_to? :iso8601
          json[key].must_equal resource[key].iso8601(3)
        else
          json[key].must_equal resource[key]
        end
      end
    end

    def verify_json_create(table, request, id)
      resource = table.find id
      request.keys.each do |key|
        resource[key].must_equal request[key]
      end
    end
  end
end

module Pundit
  module TestHelpers
    def user_with_abilities(user, kinds)
      user.user_abilities.destroy_all
      kinds.each do |kind|
        user.user_abilities.create! ability: Ability.where(kind: kind).first
      end
    end
  end
end
