class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :shop
      t.string :name
      t.string :color
      t.string :size
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock
      t.text :description
      t.boolean :on_sale, default: false
      t.timestamps
    end
  end
end
