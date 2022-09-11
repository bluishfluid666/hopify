class AddProdIdToProductImagesg < ActiveRecord::Migration[7.0]
  def change
    add_column :product_images, :product_id, :bigint
  end
end
