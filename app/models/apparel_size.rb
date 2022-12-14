# frozen_string_literal: true

class ApparelSize < ApplicationRecord
  has_many :product_stocks
  has_many :products, through: :product_stocks
end
