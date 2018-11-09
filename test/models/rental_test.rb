require "test_helper"

describe Rental do
  describe "validations" do
    it "must be valid" do
      rental_one = rentals(:rental_one)
      rental_one.valid?.must_equal true
    end

    it "must be valid if checked_out? is false" do
      rental_two = rentals(:rental_two)
      rental_two.valid?.must_equal true
    end

    it "must be invalid if due date, customer, and movie are blank" do
      invalid_rental = Rental.new()
      invalid_rental.valid?.must_equal false
    end
  end

  describe "relations" do
    it "must have a Customer" do
      rental_one = rentals(:rental_one)
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
      rental_one.customer.name.must_equal "Customer One"
      rental_one.customer.must_equal customers(:customer_one)
    end

    it "must have a Movie" do
      rental_one = rentals(:rental_one)
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
      rental_one.movie.title.must_equal "The Devil Wears Prada"
      rental_one.movie.must_equal movies(:movie_one)
    end
  end

  describe "assign_due_date" do
    let(:rental) { rentals(:rental_one) }

    it "can assign a due date 7 days from Rental creation" do
      rental.due_date = nil
      rental.due_date.must_equal nil
      rental.assign_due_date
      rental.due_date.must_equal rental.created_at.to_date + ONE_WEEK
    end
  end

  describe "check_in_movie" do
    let(:rental) { rentals(:rental_one) }

    it "can change the status of checked_out? to false" do
      rental.checked_out?.must_equal true
      rental.check_in_movie
      rental.reload
      rental.checked_out?.must_equal false
    end
  end
end
