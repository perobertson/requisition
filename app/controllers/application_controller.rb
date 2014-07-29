class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def append_info_to_payload(payload)
    # this adds a few things to logging payload
    super
    payload[:ip] = request.remote_ip
  end
end
