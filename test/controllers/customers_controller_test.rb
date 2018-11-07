require "test_helper"

describe CustomersController do
  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe 'index' do
    it 'should list all customers in JSON and renders a status code of success' do
      get customers_path, as: :json

      body = parse_json(expected_type: Array)

      expect(body.length).must_equal Customer.count

    end

    it "returns an empty array when there are no customers" do
      Customer.destroy_all

      get customers_path, as: :json

      body = parse_json(expected_type: Array)

      expect(body).must_equal []

    end
  end
end
