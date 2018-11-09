require "test_helper"

describe Movie do
  describe 'validations' do

    let(:movie_data) {
      {
        movie: {
          title: 'The Grinch',
          overview: 'The Grinch and his loyal dog, Max, live a solitary existence inside a cave on Mount Crumpet.',
          release_date: Date.parse("2017-11-06"),
          inventory: 2
        }
      }

    }

    it 'successfully creates a new movie when given valid title, overview, release_date, and inventory' do
      old_count = Movie.count
      movie = Movie.new(movie_data[:movie])

      movie.save

      movie.valid?.must_equal true
      (Movie.count).must_equal old_count + 1
      (movie.title).must_equal movie_data[:movie][:title]
      (movie.overview).must_equal movie_data[:movie][:overview]
      (movie.release_date).must_equal movie_data[:movie][:release_date]
      (movie.inventory).must_equal movie_data[:movie][:inventory]
    end

    it 'does not create a new movie when missing a title' do
      old_count = Movie.count
      movie_data[:movie][:title] = nil
      movie = Movie.new(movie_data[:movie])

      movie.valid?.must_equal false
      (Movie.count).must_equal old_count
    end

    it 'does not create a new movie when missing an overview' do
      old_count = Movie.count
      movie_data[:movie][:overview] = nil
      movie = Movie.new(movie_data[:movie])

      movie.valid?.must_equal false
      (Movie.count).must_equal old_count
    end

    it 'does not create a new movie when missing a release_date' do
      old_count = Movie.count
      movie_data[:movie][:release_date] = nil
      movie = Movie.new(movie_data[:movie])

      movie.valid?.must_equal false
      (Movie.count).must_equal old_count
    end

    it 'does not create a new movie when missing an inventory' do
      old_count = Movie.count
      movie_data[:movie][:inventory] = nil
      movie = Movie.new(movie_data[:movie])

      movie.valid?.must_equal false
      (Movie.count).must_equal old_count
    end

    it 'does not create a new movie when inventory is given as a non-integer' do
      old_count = Movie.count
      movie_data[:movie][:inventory] = "Not a number"
      movie = Movie.new(movie_data[:movie])

      movie.valid?.must_equal false
      (Movie.count).must_equal old_count
    end
  end

  describe 'relations' do

    let(:movie) { Movie.first }

    it 'has some rentals' do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

  end

  describe 'custom methods' do

    describe 'available_inventory' do

      let(:unavailable_movie) { movies(:movie_one) }
      let(:available_movie) { movies(:movie_two) }

      it 'returns the available inventory for a given movie' do
        (unavailable_movie.available_inventory).must_equal 0
        (available_movie.available_inventory).must_equal 1
      end
    end
  end
end
