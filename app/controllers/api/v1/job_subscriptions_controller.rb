class Api::V1::JobSubscriptionsController < Api::V1::ApplicationController

  before_action :set_job_subscription, only: [:show, :update]

  load_and_authorize_resource :job_subscription
  respond_to :json

  def show
    render json: @job_subscription, status: :ok
  end

  # My subscriptions as candidate
  def index
    authorize! :index, JobSubscription.new
    @q = current_user.profile.job_subscriptions.ransack(params[:q])
    @job_subscriptions = @q.result.page( params[:page] ).per(@per_page)
    render json: @job_subscriptions, each_serializer: JobSubscriptionSerializer,
           serializer: ActiveModel::Serializer::CollectionSerializer
  end

  # Create a subscription to job_advert as candidate
  def create
    @job_subscription = new_instance(job_subscription_params)
    @job_subscription.save
    render_resource @job_subscription
  end

  # Update status of a subscription
  def update
    @job_subscription.update(job_subscription_update_params)
    render_resource @job_subscription
  end

  private

  def set_job_subscription
    @job_subscription = JobSubscription.find(params[:id])
    render json: ApiMessage.not_found, status: :not_found if @job_subscription.blank?
  end

  def job_subscription_params
    params.require(:job_subscription).permit(:candidate_id, :company_id)
  end

  def job_subscription_update_params
    params.require(:job_subscription).permit(:subscription_status)
  end

  def new_instance build_params = {}
    @job_subscription = current_user.profile.job_subscriptions.build build_params
  end

end