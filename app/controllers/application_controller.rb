class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def parameter_missing(e)
    render json: e.message, status: :unprocessable_entity
  end
end
