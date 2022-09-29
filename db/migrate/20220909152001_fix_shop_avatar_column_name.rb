# frozen_string_literal: true

class FixShopAvatarColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :shops, :avatar, :shop_avatar
  end
end
