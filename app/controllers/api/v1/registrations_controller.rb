class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  skip_before_action :verify_authenticity_token
  prepend_before_action :require_no_authentication, only: :create
  before_action :configure_permitted_parameters

  respond_to :json

  def create
    begin
      profile_klass = User::PROFILE_TYPES.detect { |m| user_params[:profile_type].classify.constantize == m }
    ensure
      unless profile_klass
        build_resource(user_params.except(:profile_attributes))
        resource.save
        render_resource(resource)
        return
      end
    end
    profile_params = user_params[:profile_attributes]
    build_resource(user_params.except(:profile_attributes))
    resource.build_profile(profile_params, profile_klass)
    # resource.profile = profile_klass.new profile_params
    resource.save
    render_resource(resource)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :password_confirmation, :profile_type, profile_attributes: [:name, :description, :profession, :notes] )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email, :password, :password_confirmation, profile_attributes: [:name, :description, :profession, :notes] ] )
  end

end



