class InventoryController < ApplicationController

  before_action :authenticate_user!

  def index
    @items = Item.all.order(:name).to_a
  end
end
