class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_error

  def unpermitted_error(exception)
    render json: { message: exception.message }, status: 422
    return
  end
end
