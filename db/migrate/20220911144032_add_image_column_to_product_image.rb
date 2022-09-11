class AddImageColumnToProductImage < ActiveRecord::Migration[7.0]
  def change
    add_column :product_images, :primg, :string
  end
end
