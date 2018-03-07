class UsersController < ApplicationController
  # GET/PATCH /users/finish_signup
  def finish_signup
    unless user_signed_in?
      return redirect_to user_eve_online_omniauth_authorize_path
    end
    @user = current_user
    authorize @user, :update?

    if request.patch? && params[:user] && params[:user][:email]
      if @user.update(user_params)
        bypass_sign_in(@user)
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
