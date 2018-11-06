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
  end

  describe 'show' do
    it 'is a real working route and returns JSON' do
      movie = Movie.first
      movie_id = movie.id
      get movie_path(movie_id), as: :json
      body = parse_json(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end

    it 'returns JSON with an error message and status code of not found if pet does not exist' do
      movie = Movie.first
      movie_id = movie.id
      movie.destroy

      get movie_path(movie_id), as: :json
      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "movie_id"
    end
  end

end
