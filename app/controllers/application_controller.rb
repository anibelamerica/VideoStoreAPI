class ApplicationController < ActionController::API

  def test
    render json: { test_message: 'It works!' }
  end

  def render_error(status, errors)
    render json: { errors: errors }, status: status
  end

end
