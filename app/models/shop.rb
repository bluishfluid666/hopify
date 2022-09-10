class Shop < ApplicationRecord
  # mount_uploader :shop_avatar, ShopAvatarUploader
  belongs_to :user
  validates :user_id, presence: true
end
