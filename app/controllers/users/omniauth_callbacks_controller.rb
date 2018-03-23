# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def eve_online
      @user = User.find_for_oauth(env['omniauth.auth'], current_user)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'EVE Online') if is_navigational_format?
      else
        session["devise.#{provider}_data"] = env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end

    def after_sign_in_path_for(resource)
      Ability.create_missing!

      place_order_ability = Ability.find_by! kind: :place_order
      if resource.user_abilities.where.not(ability: place_order_ability).empty? || resource.email_verified?
        super resource
      else
        finish_signup_path
      end
    end

    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    # More info at:
    # https://github.com/plataformatec/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
  end
end
