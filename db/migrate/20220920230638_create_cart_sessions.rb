# frozen_string_literal: true

class CreateCartSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_sessions do |t|
      t.references :user
      t.decimal :total, precision: 14, scale: 2
      t.timestamps
    end
  end
end
