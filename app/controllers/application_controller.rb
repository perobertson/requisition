class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError, with: :error_render_method

  after_filter :flash_to_headers

  protected

  def append_info_to_payload(payload)
    # this adds a few things to logging payload
    super
    payload[:ip] = request.remote_ip
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

    response.headers['X-Message']      = message   || ''
    response.headers['X-Message-Type'] = type.to_s || ''

    flash.discard # don't want the flash to appear when you reload page
  end

  private

  def flash_message
    [:danger, :warning, :info, :success].each do |type|
      return flash[type] unless flash[type].blank?
    end
    nil
  end

  def flash_type
    [:danger, :warning, :info, :success].each do |type|
      return type unless flash[type].blank?
    end
    nil
  end
end
