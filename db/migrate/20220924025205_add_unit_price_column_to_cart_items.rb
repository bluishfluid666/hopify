class AddUnitPriceColumnToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :unit_price, :decimal
    rename_column :product_stocks, :unit_price, :price
  end
end
