class Api::V1::ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthorizeRequest
  include Response

  before_action :authorize_request

end
