ONE_WEEK = 7

class Rental < ApplicationRecord

  validates :checked_out?, inclusion: { in: [true, false] }

  belongs_to :customer
  belongs_to :movie

  def assign_due_date
    checkout_date = self.created_at.to_date
    self.update(due_date: (checkout_date + ONE_WEEK))
  end

  def check_in_movie
    self.update(checked_out?: false)
  end

  def self.get_overdue
    return Rental.select { |rental| rental.overdue?}
  end

  def overdue?
    return self.checked_out? && Date.today > self.due_date
  end
end
