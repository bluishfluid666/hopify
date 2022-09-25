class AddColumnSizeColorToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :color, :string
    add_reference :cart_items, :apparel_size
  end
end
