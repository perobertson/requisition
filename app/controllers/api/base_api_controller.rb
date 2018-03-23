# frozen_string_literal: true

module Api
  class BaseApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    layout false

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Callbacks
    before_action :authenticate_user!
    before_action :set_resource, only: %i[show update destroy]

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def render_nothing(status)
      head status
    end

    def index
      raise NotImplementedError
    end

    def show
      raise NotImplementedError
    end

    def update
      raise NotImplementedError
    end

    def destroy
      raise NotImplementedError
    end

  private

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
