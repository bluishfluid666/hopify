# frozen_string_literal: true

class AddSubtotalColumnToCartSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_sessions, :subtotal, :decimal
  end
end
