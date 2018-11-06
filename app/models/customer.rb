class Customer < ApplicationRecord
  validates :name, :phone, :address, :city, :state, :postal_code, presence: true
end
