Rails.application.config.lograge.enabled = true

# custom_options can be a lambda or hash
# if it's a lambda then it must return a hash
Rails.application.config.lograge.custom_options = lambda do |event|
  payload = { params: event.payload[:params].except('controller', 'action') }
  white_list = [:user_ip, :user_id, :user_agent]
  white_list.each do |key|
    if event.payload.key? key
      payload.merge!(key => event.payload[key])
    end
  end
  payload
end
