class DropProductStatsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :product_stats
  end
end
