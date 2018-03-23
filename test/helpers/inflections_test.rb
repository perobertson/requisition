# frozen_string_literal: true

require 'test_helper'

class InflectionsTest < ActiveSupport::TestCase
  it 'must not pluralize ammo' do
    'ammo'.pluralize.must_equal 'ammo'
  end
end
