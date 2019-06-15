class Api::V1::UsersController < Api::V1::ApplicationController

  before_action :set_user, only: [:show, :update]

  load_and_authorize_resource :user
  respond_to :json

  def show
    render json: @user, status: :ok
  end

  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result.page( params[:page] ).per(@per_page)
    render json: @users, each_serializer: UserSerializer,
           serializer: ActiveModel::Serializer::CollectionSerializer
  end

  def update
    @user.update(user_params)
    render_resource @user
  end

  private

  def set_user
    @user = params[:id].present? ? User.find(params[:id]) : User.find_by_username(params[:username])
    render json: ApiMessage.not_found, status: :not_found if @user.blank?
  end

  def user_params
    params.require(:user).permit(:first_mame, :last_name, :email, :password, :password_confirmation)
  end

end