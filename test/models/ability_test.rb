require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Ability.all.each do |ability|
        ability.valid?.must_equal true, ability.errors.messages
      end
    end

    it 'must have only 1 of each kind created' do
      Ability.KINDS.each do |kind|
        Ability.where(kind: kind).count.must_equal 1, kind
      end
    end

    it 'must not be able to modify kinds' do
      proc { Ability.KINDS << 'test' }.must_raise RuntimeError
      proc { Ability.KINDS = 'test' }.must_raise NoMethodError
    end
  end
end
