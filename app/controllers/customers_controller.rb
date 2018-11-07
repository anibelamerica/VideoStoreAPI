class CustomersController < ApplicationController

  def index
    if params[:sort]
      @customers = Customer.order(params[:sort])
      # binding.pry
    else
      @customers = Customer.all
    end

  end

  def show
  end

  private

end
