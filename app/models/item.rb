class Item < ActiveRecord::Base
  # Scopes
  scope(:for_sale,      -> { where(for_sale: true) })
  scope(:not_for_sale,  -> { where(for_sale: false) })

  # Relations
  has_many :orders, through: :order_items
  has_many :order_items
  belongs_to :category

  # Validations
  validates :category,  presence: true
  validates :name,      presence: true
  validates :name,      uniqueness: true
  validates :for_sale,  inclusion: [true, false]

  # type_id is the EVE type identifier
  validates :type_id,   presence: true
  validates :type_id,   numericality: { only_integer: true, greater_than: 0 }
  validates :type_id,   uniqueness: true

  before_destroy(proc { false })

  def image_url size = 64
    # TODO: validate the size choices
    if rendered?
      # Inventory type icons are available in resolutions up to 512x512.
      "https://image.eveonline.com/Render/#{type_id}_#{size}.png"
    else
      # Inventory type icons are only available in 64x64 and in 32x32.
      "https://image.eveonline.com/Type/#{type_id}_#{size}.png"
    end
  end
end
