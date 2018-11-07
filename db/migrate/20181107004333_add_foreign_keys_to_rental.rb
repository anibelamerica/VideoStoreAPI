class AddForeignKeysToRental < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :customers, foreign_key: true
    add_reference :rentals, :movies, foreign_key: true
  end
end
