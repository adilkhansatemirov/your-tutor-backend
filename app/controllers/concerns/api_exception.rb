module ApiException
  extend ActiveSupport::Concern

  class Unauthorized < StandardError; end
  class ForbiddenError < StandardError; end
  class InvalidToken < StandardError; end
  class NotFound < StandardError; end

  included do
    rescue_from StandardError,                           with: :unexpected_error
    rescue_from ArgumentError,                           with: :unprocessable_entity
    rescue_from ApiException::Unauthorized,              with: :unauthorized_request
    rescue_from ApiException::ForbiddenError,            with: :forbidden_request
    rescue_from ApiException::InvalidToken,              with: :invalid_token
    rescue_from ApiException::NotFound,                  with: :request_not_found
    rescue_from ActiveRecord::RecordInvalid,             with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound,            with: :record_not_found
    rescue_from ActionController::BadRequest,            with: :bad_request
    rescue_from ActionController::UnpermittedParameters, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing,      with: :unprocessable_entity
  end

  private

  def unprocessable_entity(error)
    render json: { message: error }, status: :unprocessable_entity
  end

  def request_not_found
    render json: { message: "404 not found" }, status: :not_found
  end

  def record_not_found
     render json: { message: "Record not found" }, status: :not_found
  end

  def invalid_token
    render json: { message: 'Invalid Token' }, status: :unauthorized
  end

  def unauthorized_request(error)
    render json: { message: error }, status: :unauthorized
  end

  def forbidden_request(error)
    render json: { message: error }, status: :forbidden
  end

  def bad_request(error)
    render json: { message: error }, status: :bad_request
  end

  def unexpected_error(error)
    ErrorReporter.report(error)
    render json: { message: error, code: 'GENERAL_ERROR' }, status: :internal_server_error
  end
end
