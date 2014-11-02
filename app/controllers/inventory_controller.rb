class InventoryController < ApplicationController

  before_action :authenticate_user!

  def index
    return user_not_authorized unless current_user.can_view_inventory?

    @items = Item.all.order(:name).to_a
    @new_item = Item.new
  end
end
