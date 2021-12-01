class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :display_record_not_found_error_message
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def parameter_missing
    render json: {error: "Parameter missing for #{params[:action]} action of #{params[:controller]} controller"}, status: :not_found
  end
end
