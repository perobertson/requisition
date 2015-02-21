class Order < ActiveRecord::Base
  include NotificationHelper

  before_validation :initialize_order_items, if: :new_record?
  after_save :send_order_notification

  has_many :order_items

  accepts_nested_attributes_for :order_items

  validates :character_name, presence: true
  validates_presence_of :order_items
  validates_associated :order_items

  private

  def send_order_notification
    send_notification self
  end

  def initialize_order_items
    order_items.each { |order_item| order_item.order = self }
  end
end
