# frozen_string_literal: true

class DeletePrimgColToProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :primg
  end
end
