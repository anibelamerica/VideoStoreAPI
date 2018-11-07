class CustomersController < ApplicationController

  def index
    # binding.pry
    if params[:sort]
      binding.pry
    end
    @customers = Customer.all

  end

  def show
  end

  private

end
