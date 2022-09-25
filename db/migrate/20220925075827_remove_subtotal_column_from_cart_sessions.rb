class RemoveSubtotalColumnFromCartSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :cart_sessions, :subtotal
  end
end
