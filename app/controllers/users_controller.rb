class UsersController < ApplicationController
  # GET/PATCH /users/finish_signup
  def finish_signup
    unless user_signed_in?
      return redirect_to user_omniauth_authorize_url(:eve_online)
    end
    @user = current_user
    authorize @user, :update?

    if request.patch? && params[:user] && params[:user][:email]
      if @user.update(user_params)
        sign_in(@user, bypass: true)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

private

  def user_params
    params.require(:user).permit :email
  end
end
