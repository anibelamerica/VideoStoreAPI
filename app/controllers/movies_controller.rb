class MoviesController < ApplicationController

  before_action :find_movie, only: [:show]

  def index
  end

  def show
    if @movie
      render json: jsonify(@movie)
    else
      render_error(:not_found, { movie_id: ["Movie does not exist"] })
    end
  end

  def create
  end

  private

  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end

  def jsonify(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory] )
  end

end
