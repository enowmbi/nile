class ErrorsController < ApplicationController
  def error_404
    requested_path = request.path
    render json: "The path #{requested_path} can not be routed. Please ensure proper case is used", status: :not_found
  end
end
