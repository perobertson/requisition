class Order < ActiveRecord::Base

  include NotificationHelper

  after_save :send_order_notification

  belongs_to :ship

  private

  def send_order_notification
    send_notification self
  end

end
