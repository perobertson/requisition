require 'test_helper'

class CategoryPolicyTest < ActiveSupport::TestCase
  include Pundit::TestHelpers

  subject { CategoryPolicy.new user, category }

  let(:user) { users(:user_no_abilities) }
  let(:category) { Category.new }

  def test_scope
    CategoryPolicy::Scope.new(user, Category).resolve.count.must_equal Category.none.count

    user_with_abilities user, %i(view_category)
    CategoryPolicy::Scope.new(user, Category).resolve.count.must_equal Category.all.count
  end

  describe 'no ability' do
    it 'must not allow show' do
      subject.show?.must_equal false
    end

    it 'must not allow create' do
      subject.create?.must_equal false
    end

    it 'must not allow update' do
      subject.update?.must_equal false
    end

    it 'must not allow destroy' do
      subject.destroy?.must_equal false
    end
  end

  describe 'has ability' do
    it 'must allow show' do
      user_with_abilities user, %i(view_category)
      subject.show?.must_equal true
    end

    it 'must allow create' do
      user_with_abilities user, %i(add_category)
      subject.create?.must_equal true
    end

    it 'must allow update' do
      user_with_abilities user, %i(change_category)
      subject.update?.must_equal true
    end

    it 'must allow destroy' do
      user_with_abilities user, %i(change_category)
      subject.destroy?.must_equal true
    end
  end
end
