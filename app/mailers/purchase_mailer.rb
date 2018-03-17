# frozen_string_literal: true
class PurchaseMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.purchase_mailer.purchase_order.subject
  #
  def purchase_order(order)
    @order = order
    # TODO: need to manage builders through the UI and not environment variables
    mail to: ENV['REQUISITION_BUILDER_EMAIL']
  end
end
