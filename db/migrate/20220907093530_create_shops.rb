# frozen_string_literal: true

class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name, unique: true, null: false
      t.references :user
      t.text :description
      t.text :homesite
      t.string :avatar

      t.timestamps
    end
  end
end
