class Api::BaseApiController < ApplicationController

  def render_nothing(status)
    render nothing: true, status: status
  end
end
