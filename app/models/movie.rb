class Movie < ApplicationRecord
  validates :title, :overview, :release_date, presence: true
  validates :inventory, presence: true, numericality: true

  has_many :rentals

  def available_inventory
    return self.inventory - self.rentals.count { |rental| rental.checked_out?}
  end
end
