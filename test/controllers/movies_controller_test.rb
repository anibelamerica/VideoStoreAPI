require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = %w(title overview release_date inventory).sort

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

      expect(body.length).must_equal Movie.count
    end

    it "returns an empty array when there are no movies" do
      Movie.destroy_all

      get movies_path, as: :json

      body = parse_json(expected_type: Array)

      expect(body).must_equal []
    end
  end

  describe 'show' do
    it 'is a real working route and returns JSON' do
      movie = Movie.first
      movie_id = movie.id
      get movie_path(movie_id), as: :json
      body = parse_json(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end

    it 'returns JSON with an error message and status code of not found if movie does not exist' do
      movie = Movie.first
      movie_id = movie.id
      movie.destroy

      get movie_path(movie_id), as: :json
      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "movie_id"
    end
  end

  describe 'create' do
    let(:movie_params) {
      {
        title: 'Rocky',
        overview: "A very rocky movie",
        release_date: "1976-11-21",
        inventory: 100
      }
    }

    it 'creates a new movie and returns JSON with an id when given valid input' do
      previous_count = Movie.count
      post movies_path, params: movie_params
      new_count = previous_count + 1

      body = parse_json(expected_type: Hash)
      expect(body.keys).must_include "id"

      movie = Movie.last
      expect(movie.title).must_equal movie_params[:title]
      expect(movie.overview).must_equal movie_params[:overview]
      expect(movie.release_date).must_equal movie_params[:release_date].to_date
      expect(movie.inventory).must_equal movie_params[:inventory]
      expect(Movie.count).must_equal new_count

    end

    it 'renders bad_request status code and returns JSON with error messages if the movie was not successfully saved' do
      movie_params[:title] = nil

      post movies_path, params: movie_params

      body = parse_json(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include "errors"
    end
  end
end
