class Api::V1::UsersController < Api::V1::ApplicationController

  before_action :set_user, only: :show

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

  def create

  end

  def update

  end

  def subscribe_to_advert

  end

  private

  def set_user
    @user = params[:id].present? ? User.find(params[:id]) : User.find_by_name(params[:name])
    render json: ApiMessage.not_found, status: :not_found if @user.blank?
  end

end