# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :shop
  has_many :product_categories
  has_many :categories, through: :product_categories, dependent: :destroy

  has_many :product_stocks, dependent: :destroy
  has_many :apparel_sizes, through: :product_stocks

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true, reject_if: proc { |attrib|
                                                                                   attrib['primg'].blank?
                                                                                 }
  accepts_nested_attributes_for :product_stocks, allow_destroy: true, reject_if: proc { |attrib|
                                                                                   attrib['color'].blank? or attrib['size'].blank? or attrib['price'].blank? or attrib['stock'].blank?
                                                                                 }
  # accepts_nested_attributes_for :product_categories, allow_destroy: true, reject_if: proc { |attrib| attrib['primg'].blank? }

  validates :description, length: { maximum: 1000 }
  validates :shop_id, presence: true
  # validates :price, presence: true
  validates :categories, presence: true
end
