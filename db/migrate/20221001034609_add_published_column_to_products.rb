# frozen_string_literal: true

class AddPublishedColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :published, :boolean, default: true
  end
end
