class MoviesController < ApplicationController

  before_action :find_movie, only: [:show]

  def index
    @movies = Movie.all
  end

  def show
    unless @movie
      render_error(:not_found, { movie_id: ["Movie does not exist"] })
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id }
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end
  
  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end

  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end
end
