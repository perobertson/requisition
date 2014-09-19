class PurchasesController < ApplicationController

  def index
    @ships = Ship.all.order :name
    @drones = Drone.all.order :name
  end

end
