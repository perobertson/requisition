require 'test_helper'

describe Item do

  describe "Sanity" do
    it "must start with valid fixtures" do
      Item.all.each do |item|
        item.valid?.must_equal true, item.errors.messages
      end
    end

    it "must not be able to modify types" do
      proc { Item.TYPES << "test" }.must_raise RuntimeError
      proc { Item.TYPES = "test" }.must_raise NoMethodError
    end
  end
end