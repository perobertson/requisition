# frozen_string_literal: true

require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Ability.all.each do |ability|
        ability.valid?.must_equal true, ability.errors.messages
      end
    end

    it 'must have only 1 of each kind created' do
      Ability.kinds.each do |kind|
        Ability.where(kind: kind).count.must_equal 1, kind
      end
    end

    it 'must not be able to modify kinds' do
      proc { Ability.kinds << 'test' }.must_raise RuntimeError
      proc { Ability.kinds = 'test' }.must_raise NoMethodError
    end
  end

  describe 'setup' do
    it 'must be able to create missing abilities' do
      UserAbility.delete_all
      Ability.delete_all
      assert_equal(0, Ability.count)
      Ability.create_missing!
      assert_equal(Ability.kinds.count, Ability.count)
    end
  end
end
