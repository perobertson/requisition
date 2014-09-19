class Item < ActiveRecord::Base
  has_many :orders, through: :order_items
  has_many :order_items

  validates :type, inclusion: ['Ship', 'Drone']

  def image_url(size = 128)
    "https://image.eveonline.com/Render/#{type_id}_#{size}.png"
  end
end
