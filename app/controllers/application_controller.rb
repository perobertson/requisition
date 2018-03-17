# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError, with: :error_render_method

  after_action :flash_to_headers

protected

  def append_info_to_payload(payload)
    # this adds a few things to logging payload
    super
    payload[:user_ip] = request.remote_ip
    payload[:user_agent] = "'#{request.user_agent}'"
  end

  def error_render_method
    respond_to do |format|
      format.html { render file: 'public/404.html', status: :not_found, layout: false }
      format.json { render json: { errors: 'Method not found.' }, status: :not_found }
    end
    true
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path, status: :see_other)
  end

  def flash_to_headers
    return unless request.xhr?

    message = flash_message
    type = flash_type

    response.headers['X-Message']      = message || ''
    response.headers['X-Message-Type'] = type.to_s || ''

    flash.discard # don't want the flash to appear when you reload page
  end

  # Its possible to ensure signup is completed before accessing resources by adding
  # before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

private

  def flash_message
    %i[danger warning info success].each do |type|
      return flash[type] if flash[type].present?
    end
    nil
  end

  def flash_type
    %i[danger warning info success].each do |type|
      return type if flash[type].present?
    end
    nil
  end
end
