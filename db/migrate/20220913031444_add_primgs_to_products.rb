# frozen_string_literal: true

class AddPrimgsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :primgs, :json
  end
end
