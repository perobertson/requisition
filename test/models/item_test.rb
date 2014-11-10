require 'test_helper'

describe Item do
  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Item.all.each do |item|
        item.valid?.must_equal true, item.errors.messages
      end
    end
  end
end
