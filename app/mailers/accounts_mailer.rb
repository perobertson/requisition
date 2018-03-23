# frozen_string_literal: true

class AccountsMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  default from: "EVE Requisition <#{ENV['MAILER_FROM_EMAIL']}>"
end
