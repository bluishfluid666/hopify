# frozen_string_literal: true

class DeletePrimgsProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :primgs
  end
end
