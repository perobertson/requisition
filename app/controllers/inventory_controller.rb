# frozen_string_literal: true
class InventoryController < ApplicationController
  before_action :authenticate_user!

  def index
    return user_not_authorized unless current_user.can_view_inventory?

    @categories = Category.order(:name)
    @new_item = Item.new
  end
end
