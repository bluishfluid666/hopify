class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :product_stock
      t.references :cart_session
      t.integer :quantity
      t.timestamps
    end
  end
end
