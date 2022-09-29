# frozen_string_literal: true

class CreateApparelSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :apparel_sizes do |t|
      t.string :title
      t.timestamps
    end
  end
end
