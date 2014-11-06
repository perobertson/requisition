Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # make the mailer raise errors if it fails so we can diagnose in debug
  config.action_mailer.raise_delivery_errors = true

  ActionMailer::Base.default from: "EVE Requisition <#{ENV['REQUISITION_MAILER_ACCOUNT']}>"

  config.action_mailer.smtp_settings = {
    address:                "smtp.mandrillapp.com",
    port:                   587,                      # ports 587 and 2525 are also supported with STARTTLS
    enable_starttls_auto:   true,                     # detects and uses STARTTLS
    authentication:         'login',                  # Mandrill supports 'plain' or 'login'
    user_name:              ENV['REQUISITION_MANDRILL_USERNAME'],
    password:               ENV['REQUISITION_MANDRILL_APIKEY'],  # SMTP password is any valid API key
    domain:                 ENV['REQUISITION_MAILER_DOMAIN'],     # your domain to identify your server when connecting
  }
  # for devise
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use lograge for many wins
  config.lograge.enabled = true

  # This makes sure that request params get dumped into the same single line that lograge outputs
  # See ActionController's append_info_to_payload() function for other things we're adding
  config.lograge.custom_options = lambda do |event|
    payload = { "params" => event.payload[:params].except('controller', 'action') }
    payload.merge(event.payload.select { |k,v| [:ip].include?(k) && v.present? })
  end
end
