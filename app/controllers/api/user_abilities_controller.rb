class Api::UserAbilitiesController < Api::BaseApiController
  def create
    unless current_user.can_change_user?
      flash[:danger] = 'You are not authorized to perform this action'
      return render_nothing :unauthorized
    end

    @user_ability = UserAbility.new permitted_create_params
    if params[:user_id].present?
      @user_ability.user_id = params[:user_id]
    end

    if params[:user_ability] && !@user_ability.ability_id
      ability = Ability.find_by_kind params[:user_ability][:kind]
      @user_ability.ability = ability
    end

    if @user_ability.save
      flash[:success] = 'Ability added'
      return render status: :created
    end
    render status: :unprocessable_entity
  end

  def destroy
    unless current_user.can_change_user?
      flash[:danger] = 'You are not authorized to perform this action'
      return render_nothing :unauthorized
    end

    if @user_ability.ability.kind == :change_user.to_s
      return render_nothing :unauthorized
    end

    @user_ability.deleted_at = Time.current
    if @user_ability.save
      flash[:success] = 'Ability removed'
      return render_nothing :no_content
    end

    render_nothing :unprocessable_entity
  end

private

  def set_resource
    @user_ability = UserAbility.find params[:id]
  end

  def permitted_create_params
    params.require(:user_ability).permit :user_id, :ability_id
  end
end
