# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "EVE Requisition <#{ENV['MAILER_FROM_EMAIL']}>"
  layout 'mailer'
end
