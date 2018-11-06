require "test_helper"

describe CustomersController do
  # it "should get index" do
  #   get customers_index_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get show" do
  #   get customers_show_url
  #   value(response).must_be :success?
  # end

  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe 'index' do
    it 'should list all customers in JSON and renders a status code of success' do
      # Act
      get customers_path

      # Assert
      body = parse_json(expected_type: Array)

      expect(body.length).must_equal Customer.count

      # body.each do |pet|
      #   expect(pet.keys.sort).must_equal PET_FIELDS
      # end
    end

    it "returns an empty array when there are no pets" do
      Customer.destroy_all

      get customers_path

      #Assert
      body = parse_json(expected_type: Array)

      expect(body).must_equal []

    end
  end

end
