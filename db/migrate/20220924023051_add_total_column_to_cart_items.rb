# frozen_string_literal: true

class AddTotalColumnToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :total, :decimal
  end
end
