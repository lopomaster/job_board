# app/lib/api_message.rb
class ApiMessage
  def self.not_found(record = 'record')
    { message: "Sorry, #{record} not found.", code: 'NF'}
  end

  def self.invalid_credentials
    { message: 'Invalid credentials', code: 'IC'}
  end

  def self.invalid_token
    { message: 'Invalid token', code: 'IT'}
  end

  def self.missing_token
    { message: 'Missing token', code: 'MT'}
  end

  def self.unauthorized
    { message: 'Unauthorized request', code: 'UR'}
  end

  def self.account_created
    { message: 'Account created successfully', code: 'AC'}
  end

  def self.account_not_created
    { message: 'Account could not be created', code: 'ANC'}
  end

  def self.expired_token
    { message: 'Sorry, your token has expired. Please login to continue.', code: 'TE'}
  end

  def self.unprocessable_entity
    { message: 'Unprocessable entity', code: 'UE'}
  end

  def self.verification_error
    { message: 'Token verification error', code: 'VE'}
  end

end