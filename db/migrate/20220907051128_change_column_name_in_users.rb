class ChangeColumnNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :role, :admin
  end
end
