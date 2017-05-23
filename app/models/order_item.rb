class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates :order,     presence: true
  validates :item,      presence: true
  validates :item,      uniqueness: { scope: :order }
  validates :quantity,  presence: true
  validates :quantity,  numericality: { only_integer: true, greater_than: 0 }

  # Do not uncomment. This will cause a circular validation
  # validates_associated :order
  validates_associated :item

  before_destroy(proc { false })
end
