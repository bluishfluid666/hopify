class Product < ApplicationRecord
  belongs_to :shop
  has_many :product_images
  accepts_nested_attributes_for :product_images
  validates :description, length: { maximum: 1000 }
  validates :shop_id, presence: true
  validates :price, presence: true
end
