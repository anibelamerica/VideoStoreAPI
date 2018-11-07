class RenameRentalsColumnReferences < ActiveRecord::Migration[5.2]
  def change

    remove_reference :rentals, :customers, foreign_key: true
    remove_reference :rentals, :movies, foreign_key: true

    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true

  end
end
