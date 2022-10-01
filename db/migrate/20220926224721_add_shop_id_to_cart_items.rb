# frozen_string_literal: true

class AddShopIdToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :shop, foreign_key: true
  end
end
