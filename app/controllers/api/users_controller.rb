# frozen_string_literal: true
module Api
  class UsersController < Api::BaseApiController
    def index
      @users = policy_scope User.all
    end

    def show
    end

    def update
      if @resource.update permitted_update_params
        return render_nothing :no_content
      end
      render_nothing :unprocessable_entity
    end

  private

    def set_resource
      @resource = User.find params[:id]
      authorize @resource
    end

    def permitted_update_params
      params.require(:user).permit(:email)
    end
  end
end
