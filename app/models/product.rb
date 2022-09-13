class Product < ApplicationRecord
  belongs_to :shop
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true, reject_if: proc { |attrib| attrib['primg'].blank? }
  validates :description, length: { maximum: 1000 }
  validates :shop_id, presence: true  
  validates :price, presence: true
end
