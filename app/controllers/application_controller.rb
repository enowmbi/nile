class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :display_record_not_found_error_message
end
