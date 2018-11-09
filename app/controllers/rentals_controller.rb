class RentalsController < ApplicationController
  def create # checkout-out method
    rental = Rental.new(rental_params)
    movie = Movie.find_by(id: params[:movie_id])

    if !movie
      render_error(:bad_request, { movie: ["Movie must exist"] })
      return
    elsif movie.available_inventory < 1
      render_error(:bad_request, { inventory: ["Not enough inventory available"] })
      return
    end

    if rental.save
      rental.assign_due_date
      render json: { id: rental.id }
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  def update
    customer_id = params[:customer_id]
    movie_id = params[:movie_id]

    rental = Rental.find_by(
      customer_id: customer_id,
      movie_id: movie_id,
      checked_out?: true
    )

    rental.check_in_movie
    if rental.save
      render json: { id: rental.id }
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  def overdue
    @rentals = Rental.get_overdue
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
