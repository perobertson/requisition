# frozen_string_literal: true

require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  subject { order }

  describe 'Sanity' do
    it 'must start with valid fixtures' do
      OrderItem.all.each do |record|
        record.valid?.must_equal true, record.errors.messages
      end
    end
  end

  describe 'Validations' do
    it 'must not be destroyed' do
      order_item = OrderItem.all.sample
      -> { order_item.destroy! }.must_raise ActiveRecord::RecordNotDestroyed
    end
  end
end
