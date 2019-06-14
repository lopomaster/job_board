module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from StandardError do |e|
      error message: e.message, code: 'OT'
    end
    rescue_from ActiveRecord::RecordInvalid do |e|
      error ApiMessage.unprocessable_entity
    end
    rescue_from ExceptionHandler::AuthenticationError do |e|
      unauthorized ApiMessage.unprocessable_entity
    end
    rescue_from ExceptionHandler::MissingToken do |e|
      unauthorized ApiMessage.missing_token
    end
    rescue_from ExceptionHandler::InvalidToken do |e|
      unauthorized ApiMessage.invalid_token
    end
    rescue_from JWT::VerificationError do |e|
      unauthorized ApiMessage.verification_error
    end
    rescue_from JWT::ExpiredSignature do |e|
      unauthorized ApiMessage.unauthorized
    end
    rescue_from JWT::DecodeError do |e|
      unauthorized ApiMessage.unauthorized
    end
    rescue_from ActiveRecord::RecordNotFound do |e|
      not_found ApiMessage.not_found
    end

  end

  private

  def unauthorized message
    json_response({ message: message }, :unauthorized)
  end

  def error message
    json_response({ message: message }, :error)
  end

  def not_found message
    json_response({ message: message }, :not_found)
  end

end