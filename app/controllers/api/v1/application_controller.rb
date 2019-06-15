class Api::V1::ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthorizeRequest
  include Response

  before_action :authorize_request

  before_action :set_default_per_page, only: :index

  private

  def set_default_per_page
    @per_page = params[:per_page] || 10
  end

end
