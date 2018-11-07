require "test_helper"

describe Rental do
  let(:rental) { Rental.first }
  #
  # it "must be valid" do
  #   value(rental).must_be :valid?
  # end

  describe 'due_date' do
    it 'returns the date for which this instance of rental is due' do
      expected_due_date = rental.created_at + 7

      expect(rental.due_date).must_equal expected_due_date
    end
  end

  describe 'overdue?' do
    it 'returns true if this instance of rental is overdue' do
      #Arrange
      #TODO: update an existing rental so that it's overdue
      #rental = Rental.first
      #patch rentals_path(rental.id)

      expect(rental.overdue?).must_equal true
    end

    it 'returns false if this instance of rental is not overdue' do
      #Arrange
      #TODO: create a new rental or grab one that's definitely not overdue
      #rental = Rental.create

      expect(rental.overdue?).must_equal false
    end
  end

end
