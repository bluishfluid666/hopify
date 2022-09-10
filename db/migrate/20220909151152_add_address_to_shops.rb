class AddAddressToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :address, :string
  end
end
