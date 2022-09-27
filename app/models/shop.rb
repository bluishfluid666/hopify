class Shop < ApplicationRecord
  mount_uploader :shop_avatar, ShopAvatarUploader
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :order_items, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
