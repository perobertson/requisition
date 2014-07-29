class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError, with: :error_render_method

  def append_info_to_payload(payload)
    # this adds a few things to logging payload
    super
    payload[:ip] = request.remote_ip
  end

  def error_render_method
    respond_to do |format|
      format.html { render file: 'public/404.html', status: :not_found, layout: false }
      format.json { render json: { errors: "Method not found." }, status: :not_found }
    end
    true
  end
end
