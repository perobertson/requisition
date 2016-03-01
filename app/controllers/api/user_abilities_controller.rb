module Api
  class UserAbilitiesController < Api::BaseApiController
    def create
      @resource = UserAbility.new permitted_create_params
      if params[:user_id].present?
        @resource.user_id = params[:user_id]
      end

      if params[:user_ability] && !@resource.ability_id
        ability = Ability.find_by_kind params[:user_ability][:kind]
        @resource.ability = ability
      end

      authorize @resource
      if @resource.save
        return render status: :created
      end
      render status: :unprocessable_entity
    end

    def destroy
      if @resource.ability.kind == :change_user.to_s
        return render_nothing :unauthorized
      end

      if @resource.destroy
        return render_nothing :no_content
      end

      render_nothing :unprocessable_entity
    end

  private

    def permitted_create_params
      params.require(:user_ability).permit :user_id, :ability_id
    end
  end
end
