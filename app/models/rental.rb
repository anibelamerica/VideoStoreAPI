class Rental < ApplicationRecord
  ONE_WEEK = 7

  validates :checked_out?, inclusion: { in: [true, false] }

  belongs_to :customer
  belongs_to :movie

  def self.assign_due_date
    checkout_date = self.created_at.to_date
    self.update(due_date: (checked_out + ONE_WEEK))
  end

  def self.check_in_movie
    self.update(checked_out?: false)
  end
end
