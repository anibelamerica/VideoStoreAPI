class Customer < ApplicationRecord
  validates :name, :phone, :address, :city, :state, :postal_code, presence: true

  has_many :rentals

  def movies_checked_out
    return self.rentals.select { |rental| rental.checked_out? }
  end

  def movies_checked_out_count
    return movies_checked_out.count
  end

end
