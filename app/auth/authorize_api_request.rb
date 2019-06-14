class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token['sub']) if decoded_auth_token
  end

  # decode authentication token
  def decoded_auth_token
    token = http_auth_header
    @decoded_auth_token ||= Warden::JWTAuth::TokenDecoder.new.call(token) if token
  end

  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, ApiMessage.missing_token[:message])
  end
end
