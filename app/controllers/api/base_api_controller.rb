module Api
  class BaseApiController < ApplicationController
    layout false

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Callbacks
    before_action :authenticate_user!
    before_action :set_resource, only: [:show, :update, :destroy]

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def render_nothing status
      render nothing: true, status: status
    end

  private

    def set_resource
      table = params[:controller].classify.match(/^Api::(.*)/)[1].constantize
      @resource = table.find params[:id]
      authorize @resource
    end

    def user_not_authorized
      if params[:action] == 'create'
        render_nothing :forbidden
      else
        # Dont expose the existance of a resource
        render_nothing :not_found
      end
    end
  end
end
