# frozen_string_literal: true

class ChangePrImgName < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :primgs, :primg
  end
end
