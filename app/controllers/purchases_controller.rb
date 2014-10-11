class PurchasesController < ApplicationController

  def index
    @ships = Ship.for_sale.order(:name).to_a
    @drones = Drone.for_sale.order(:name).to_a
  end

end
