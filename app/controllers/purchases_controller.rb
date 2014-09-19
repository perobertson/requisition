class PurchasesController < ApplicationController

  def index
    @ships = Ship.all
    @drones = Drone.all
  end

end
