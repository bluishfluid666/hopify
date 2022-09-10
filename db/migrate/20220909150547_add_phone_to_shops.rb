class AddPhoneToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :phone, :string
  end
end
