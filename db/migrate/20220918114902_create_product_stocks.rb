class CreateProductStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :product_stocks do |t|
      t.references :product
      t.references :apparel_size
      t.string :color
      t.integer :stock
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
    remove_column :products, :color
    remove_column :products, :size
    remove_column :products, :price
    remove_column :products, :stock
  end
end
