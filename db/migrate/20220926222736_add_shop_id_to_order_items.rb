# frozen_string_literal: true

class AddShopIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_items, :shop, index: true
  end
end
