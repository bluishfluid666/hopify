# frozen_string_literal: true

class SetDefaultPrImgValue < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :primg, :json, default: nil
  end
end
