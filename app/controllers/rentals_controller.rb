class RentalsController < ApplicationController
  def create # checkout-out method
    rental = Rental.new(rental_params)

    if rental.save
      rental.assign_due_date
      # movie.remove_inventory
      # For optionals with inventory, need to change amount when movie is checked out.

      render json: { id: rental.id }
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  def update
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id] )

    rental.check_in_movie
    if rental.save
      # movie.add_inventory
      # For optionals with inventory, need to change amount when movie is checked back in.
      render json: { id: rental.id }
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
