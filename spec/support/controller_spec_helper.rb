module ControllerSpecHelper
  require 'devise/jwt/test_helpers'

  # return valid headers
  def valid_headers(user)
    header = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(header, user)
  end

  # return valid token
  def valid_token(user)
    header = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    header = Devise::JWT::TestHelpers.auth_headers(header, user)
    header['Authorization']
  end

  # return invalid headers
  def invalid_headers
    {
        "Authorization" => nil,
        "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers_token
    {
        "Authorization" => invalid_token,
        "Content-Type" => "application/json"
    }
  end

  def invalid_token
    'fake_token.fake_token.fake_token'
  end

end