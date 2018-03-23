# frozen_string_literal: true

module NotificationHelper
  def send_notification(order)
    PurchaseMailer.purchase_order(order).deliver_later
  end
end
