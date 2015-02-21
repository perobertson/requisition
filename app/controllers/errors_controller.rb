class ErrorsController < ApplicationController
  def catch_404
    fail ActionController::RoutingError.new(params[:path])
  end
end
