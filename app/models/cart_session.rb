class CartSession < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  before_save :set_total
  def total
    cart_items.collect{ |cart_item| cart_item.valid? ? cart_item.product_stock.price * cart_item.quantity : 0 }.sum
  end 

  private
    def set_total
      self[:total] = total
    end
end
