class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  skip_before_action :verify_authenticity_token
  prepend_before_action :require_no_authentication, only: :create
  before_action :configure_permitted_parameters

  respond_to :json

  def create
    build_resource(user_params)
    resource.save
    render_resource(resource)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :password_confirmation)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email, :password, :password_confirmation])
  end

end



