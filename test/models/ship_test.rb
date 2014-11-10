require 'test_helper'

describe Ship do
  describe "validations" do
    it "must create a valid ship" do
      ship = Ship.new valid_ship
      ship.valid?.must_equal true, ship.errors.messages
      ship.save!
    end

    it "must require category" do
      not_valid_check :category
    end

    it "must require type_id" do
      not_valid_check :type_id
    end

    it "must require name" do
      not_valid_check :name
    end

    it "must require for_sale" do
      not_valid_check :for_sale
    end

    def not_valid_check(attribute)
      ship = Ship.new valid_ship attribute
      ship.valid?.must_equal false
      ship.errors[attribute].present?.must_equal true
    end
  end

  def valid_ship(attributes_to_delete = nil)
    {
      type_id: 1,
      name: 'Test ship',
      for_sale: true,
      category: categories(:category_ship)
    }.except!(*attributes_to_delete)
  end
end
