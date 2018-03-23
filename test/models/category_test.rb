# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  subject { category }

  describe 'Sanity' do
    it 'must start with valid fixtures' do
      Category.all.each do |category|
        category.valid?.must_equal true, category.errors.messages
      end
    end
  end

  describe 'validations' do
    let(:category) { Category.new }

    it 'must destroy a category without items' do
      subject.destroy.must_equal subject
    end

    it 'must not destroy a category with items' do
      subject.items.push Item.new
      subject.destroy.must_equal false
      subject.errors[:base].wont_be_empty
    end

    it 'must require a name' do
      subject.must_be :invalid?
      subject.errors[:name].wont_be_empty
      subject.name = 'Drones'
      subject.must_be :valid?, subject.errors
    end

    it 'must require a unique name' do
      subject.name = Category.first.name
      subject.must_be :invalid?
      subject.errors[:name].wont_be_empty
    end
  end
end
