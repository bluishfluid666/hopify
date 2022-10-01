# frozen_string_literal: true

class ProductStock < ApplicationRecord
  belongs_to :product
  belongs_to :apparel_size
  has_many :cart_items, dependent: :destroy
end
