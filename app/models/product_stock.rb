class ProductStock < ApplicationRecord
  belongs_to :product
  belongs_to :apparel_size
end
