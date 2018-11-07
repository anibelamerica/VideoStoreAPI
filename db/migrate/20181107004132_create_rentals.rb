class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.boolean :checked_out?, default: true

      t.timestamps
    end
  end
end
