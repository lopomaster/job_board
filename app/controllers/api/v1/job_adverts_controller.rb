class Api::V1::JobAdvertsController < Api::V1::ApplicationController

before_action :set_job_advert, only: [:show, :update]

  load_and_authorize_resource :job_advert, except: [ :my_adverts_as_company, :my_adverts_as_candidate]
  respond_to :json

  def show
    render json: @job_advert, status: :ok
  end

  # My adverts as company
  def my_adverts_as_company
    authorize! :my_adverts_as_company, JobAdvert.new
    @q = current_user.profile.job_adverts.ransack(params[:q])
    @job_adverts = @q.result.page( params[:page] ).per(@per_page)
    render json: @job_adverts, each_serializer: JobAdvertSerializer,
           serializer: ActiveModel::Serializer::CollectionSerializer
  end

  # My adverts as candidate
  def my_adverts_as_candidate
    authorize! :my_adverts_as_candidate, JobAdvert.new
    @q = current_user.profile.subscription_job_adverts.ransack(params[:q])
    @job_adverts = @q.result.page( params[:page] ).per(@per_page)
    render json: @job_adverts, each_serializer: JobAdvertSerializer,
           serializer: ActiveModel::Serializer::CollectionSerializer
  end

  # List all adverts
  def list_adverts
    @q = JobAdvert.all.ransack(params[:q])
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
    @job_advert.update(job_advert_params)
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


  def new_instance build_params = {}
    @job_advert = current_user.profile.job_adverts.build build_params
  end

end