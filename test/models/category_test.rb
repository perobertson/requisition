require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Category.all.each do |category|
        category.valid?.must_equal true, category.errors.messages
      end
    end
  end
end
