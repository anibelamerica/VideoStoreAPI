class Rental < ApplicationRecord
  ONE_WEEK = 7

  validates :checked_out?, inclusion: { in: [true, false] }

  belongs_to :customer
  belongs_to :movie

  def assign_due_date
    checkout_date = self.created_at
    self.update(due_date: (checkout_date + ONE_WEEK))
  end

  def check_in_movie
    self.update(checked_out?: false)
  end
end
