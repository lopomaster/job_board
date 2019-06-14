class Api::V1::SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers

  skip_before_action :verify_authenticity_token
  prepend_before_action :require_no_authentication, only: [:create]
  before_action :rewrite_param_names, only: [:create]

  def new
    render json: Message.missing_token, status: 401
  end

  def create
    user = User.find_by_username(params.dig(:session, :user, :username))
    resource = warden.authenticate(:scope => :user)
    yield resource if block_given?
    if user and current_token
      sign_in(resource_name, resource)
      render json: {success: true, jwt: current_token, message: "Authentication successful" }, status: :ok
    else
      render json: {success: false, jwt: nil, message: "Authentication failed", code: 'AF' }, status: :unauthorized
    end
  end

  private

  def rewrite_param_names
    request.params[:user] = {username: request.params[:username], password: request.params[:password]}
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

end