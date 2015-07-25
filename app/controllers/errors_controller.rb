class ErrorsController < ApplicationController
  def not_found
    render json: { error: 'not found' }, status: :not_found
  end

  def unprocessable_entity
    render json: { error: 'unprocessable entity' }, status: :unprocessable_entity
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end
end
