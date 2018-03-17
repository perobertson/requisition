# frozen_string_literal: true
class Order < ApplicationRecord
  include NotificationHelper

  # Associations
  has_many :order_items
  belongs_to :user

  accepts_nested_attributes_for :order_items

  # Callbacks / Validations
  before_validation :initialize_order_items, if: :new_record?

  validates :user,            presence: true
  validates :order_items,     presence: true
  validates_associated :order_items

  after_save :send_order_notification

  before_destroy(proc { throw :abort })

private

  def send_order_notification
    send_notification self
  end

  def initialize_order_items
    order_items.each { |order_item| order_item.order = self }
  end
end
