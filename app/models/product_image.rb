class ProductImage < ApplicationRecord
  mount_uploader :primg, ProdImgUploader
  belongs_to :product
end
