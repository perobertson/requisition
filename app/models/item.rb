class Item < ActiveRecord::Base

  @@TYPES = [:Ship, :Drone]
  cattr_reader :TYPES

  scope :for_sale, -> { where(for_sale: true) }
  scope :not_for_sale, -> { where(for_sale: false) }

  has_many :orders, through: :order_items
  has_many :order_items

  validates :type, inclusion: @@TYPES.map(&:to_s)
  validates :type_id, presence: true
  validates :type_id, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true
  validates :for_sale, presence: true

  def image_url(size = 128)
    "https://image.eveonline.com/Render/#{type_id}_#{size}.png"
  end

end
