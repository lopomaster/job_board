class ApplicationController < ActionController::Base

  before_action :token_authentication, unless: :user_signed_in?, except: [:parse_results, :exempt_data, :departments_info, :check_status]


  def token_authentication
    request.headers['Authorization'] = params['Authorization']
    begin
      user = AuthorizeApiRequest.new(request.headers).call
    rescue ExceptionHandler::MissingToken
    end
    sign_in(user) if user.present?
  end

end
