class Shop < ApplicationRecord
  # mount_uploader :shop_avatar, ShopAvatarUploader
  belongs_to :user
  has_many :products, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
