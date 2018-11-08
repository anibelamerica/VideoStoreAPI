require "test_helper"

describe RentalsController do

  RENTAL_FIELDS = %w(movie_id title customer_id name postal_code checkout_date due_date)

  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "create" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_two).id,
        movie_id: movies(:movie_two).id
      }
    }

    it "Creates a new rental" do
      expect {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 1

      new_rental = Rental.last
      new_rental.checked_out?.must_equal true
      must_respond_with :success
    end

    it "does not create a rental for a movie that does not have available inventory and renders a bad request" do
      expect {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 1

      new_rental = Rental.last
      new_rental.checked_out?.must_equal true
      must_respond_with :success

      expect {
        post check_out_path, params: rental_data
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
    end

    it "returns a bad request for incorrectly creating a rental" do
      rental_data.delete(:customer_id)

      expect {
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', 0

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "customer"
    end
  end

  describe "update" do

    let(:rental_data) {
      {
        customer_id: customers(:customer_two).id,
        movie_id: movies(:movie_two).id
      }
    }

    let(:checked_out_rental) {rentals(:rental_one)}
    let(:checked_in_rental) {rentals(:rental_two)}

    it "Updates a rental thats is checked-out to be checked-in" do

      post check_out_path, params: rental_data

      rental = Rental.last
      rental.checked_out?.must_equal true

      post check_in_path(customer_id: customers(:customer_two).id, movie_id: movies(:movie_two).id)

      rental.reload

      rental.checked_out?.must_equal false
    end

    it "does not update a rental that has been checked back in already" do
      checked_in_rental.checked_out?.must_equal false

      post check_in_path(customer_id: customers(:customer_one).id, movie_id: movies(:movie_one).id)

      checked_in_rental.checked_out?.must_equal false
    end

  end

  # describe 'overdue' do
  #   it 'returns a list of all customers with overdue books in JSON with a status code of success' do
  #     #Arrange
  #     # TODO create rentals in yml files with overdue parameters, or
  #     # update yml rentals to change checked_out? to true (as long as date is
  #     # more than 1 week ago)
  #
  #     get overdue_rentals_path
  #
  #     body = parse_json(expected_type: Array)
  #
  #     expect(body.keys.sort).must_equal MOVIE_FIELDS
  #   end
  #
  #   it 'returns an empty array with a status code of success if there are no customers with overdue books' do
  #     get overdue_rentals_path
  #
  #     body = parse_json(expected_type: Array)
  #     expect(body).must_equal []
  #   end
  # end

end
