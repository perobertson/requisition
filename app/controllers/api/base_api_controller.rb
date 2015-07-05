module Api
  class BaseApiController < ApplicationController
    layout false

    # Callbacks
    before_action :authenticate_user!
    before_action :set_resource, only: [:show, :update, :destroy]

    def render_nothing status
      render nothing: true, status: status
    end
  end
end
