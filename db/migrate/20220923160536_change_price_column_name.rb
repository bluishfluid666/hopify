class ChangePriceColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_stocks, :price, :unit_price
  end
end
