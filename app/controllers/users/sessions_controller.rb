# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_filter :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
      redirect_to user_eve_online_omniauth_authorize_path
    end

    # POST /resource/sign_in
    def create
      redirect_to user_eve_online_omniauth_authorize_path
    end

    # DELETE /resource/sign_out
    def destroy
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
