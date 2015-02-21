require 'test_helper'

describe Ship do
  before do
    @valid_ship = {
      type_id: 1,
      name: 'Test ship',
      for_sale: true
    }
  end

  it 'must create a valid ship' do
    ship = Ship.new @valid_ship
    ship.valid?.must_equal true, ship.errors.messages
    ship.save!
    ship.type = 'Invalid'
    proc { ship.save! }.must_raise ActiveRecord::RecordInvalid
  end
end
