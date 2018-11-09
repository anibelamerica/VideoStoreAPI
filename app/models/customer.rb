class Customer < ApplicationRecord
  validates :name, :phone, :address, :city, :state, :postal_code, presence: true

  has_many :rentals

  def movies_checked_out_count
    return self.rentals.count { |rental| rental.checked_out? }
  end

end
