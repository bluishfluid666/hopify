# frozen_string_literal: true

class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images, &:timestamps
  end
end
