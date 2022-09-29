# frozen_string_literal: true

class Order < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |attrib|
                                                                                attrib['product_stock_id'].nil?
                                                                              }
end
