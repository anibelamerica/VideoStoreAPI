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

  describe 'overdue' do
    it 'returns a list of all customers with overdue books in JSON with a status code of success' do
      #Arrange
      # TODO create rentals in yml files with overdue parameters, or
      # update yml rentals to change checked_out? to true (as long as date is
      # more than 1 week ago)

      get overdue_rentals_path

      body = parse_json(expected_type: Array)

      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end

    it 'returns an empty array with a status code of success if there are no customers with overdue books' do
      get overdue_rentals_path

      body = parse_json(expected_type: Array)
      expect(body).must_equal []
    end
  end

end
