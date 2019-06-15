class Api::V1::ApplicationController < ActionController::API
  include ApplicationHelper
  include ExceptionHandler
  include AuthorizeRequest
  include Response

  before_action :authorize_request
  before_action :set_default_per_page, only: :index
  before_action :configure_permitted_parameters, if: :devise_controller?

  def routing_error
    not_found ApiMessage.invalid_route
  end

  private

  def set_default_per_page
    @per_page = params[:per_page] || 10
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
