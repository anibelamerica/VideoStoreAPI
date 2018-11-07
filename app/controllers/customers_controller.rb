require 'will_paginate/array'

class CustomersController < ApplicationController

  def index
    valid_params = %w(name registered_at postal_code)

    if valid_params.include?(params[:sort])
      sort = params[:sort]
    end

    @customers = Customer.order(sort).paginate(page: params[:p], per_page: params[:n])
  end

  def show
  end

  private

end
