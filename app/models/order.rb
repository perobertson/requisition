class Order < ActiveRecord::Base

  include NotificationHelper

  after_save :send_order_notification

  belongs_to :ship, foreign_key: "item_id"

  validates :character_name, presence: true

  private

  def send_order_notification
    send_notification self
  end

end
