class PurchasesController < ApplicationController

  def index
    @items = Item.for_sale.order(:name).to_a
  end

end
