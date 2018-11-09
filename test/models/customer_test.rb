require "test_helper"

describe Customer do

  describe 'validations' do
    let(:customer) { customers(:customer_one) }

    it "must be valid" do
      value(customer).must_be :valid?
    end

    it "must have a name" do
      customer.name = nil
      customer.valid?.must_equal false
    end

    it "must have a phone" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a address" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a city" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a state" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a postal_code" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a phone" do
      customer.phone = nil
      customer.valid?.must_equal false
    end
  end

  describe 'relations' do
    it 'can have many rentals' do
      customer = customers(:customer_one)
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe 'custom methods' do

    describe 'movies_checked_out_count' do
      it 'returns the number of movies currently checked out by this customer' do
        customer = customers(:customer_one)

        result = customer.movies_checked_out_count
        expect(result).must_equal 1
      end
    end
  end
end
