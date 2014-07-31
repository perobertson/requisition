class PurchasesController < ApplicationController

  def index
    @ships = Ship.all
  end

end
