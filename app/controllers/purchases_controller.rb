# frozen_string_literal: true

class PurchasesController < ApplicationController
  def index
    for_sale = policy_scope(Item).joins(:category).for_sale.order :name
    @items = {}
    Category.names.each do |name|
      @items[name.to_sym] = for_sale.where categories: { name: name }
    end
  end

  def history
    @orders = current_user.orders.eager_load(order_items: :item).order created_at: :desc
  end
end
