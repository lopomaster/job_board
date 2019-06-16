class Api::V1::JobAdvertsController < Api::V1::ApplicationController

before_action :set_job_advert, only: [:show, :update]

  load_and_authorize_resource :job_advert
  respond_to :json

  def show
    render json: @job_advert, status: :ok
  end

  def index
    @q = current_user.profile.job_adverts.ransack(params[:q])
    @job_adverts = @q.result.page( params[:page] ).per(@per_page)
    render json: @job_adverts, each_serializer: JobAdvertSerializer,
           serializer: ActiveModel::Serializer::CollectionSerializer
  end

  def create
    @job_advert = new_instance(job_advert_params)
    @job_advert.save
    render_resource @job_advert
  end

  def update
    @job_advert.update(user_params)
    render_resource @job_advert
  end

  private

  def set_job_advert
    @job_advert = JobAdvert.find(params[:id])
    render json: ApiMessage.not_found, status: :not_found if @job_advert.blank?
  end

  def job_advert_params
    params.require(:job_advert).permit(:description)
  end


  def new_instance build_params
    @job_advert = current_user.profile.job_adverts.build build_params
  end

end