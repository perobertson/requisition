class Api::BaseApiController < ApplicationController

  layout false

  before_action :set_resource, only: [:show, :update, :destroy]

  def render_nothing(status)
    render nothing: true, status: status
  end
end
