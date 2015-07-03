class FillOutCategories < ActiveRecord::Migration
  def up
    types = Item.pluck(:type).uniq
    types.each do |type|
      category = Category.find_by_name type
      category = Category.create! name: type unless category

      Item.where(type: type).update_all category_id: category.id
    end

    change_column_null :items, :category_id, false
  end

  def down
    change_column_null :items, :category_id, true

    categories = Category.pluck(:name).uniq
    categories.each do |category|
      type = category.gsub(" ", "_").classify
      Item.joins(:category).where(categories: {name: category}).update_all type: type
    end
  end
end
