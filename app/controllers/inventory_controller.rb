class InventoryController < ApplicationController

  before_action :authenticate_user!

  def index
  end
end
