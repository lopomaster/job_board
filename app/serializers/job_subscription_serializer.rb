class JobSubscriptionSerializer < ApplicationSerializer
  attributes :subscription_status, :created_at
  has_one :job_advert
  has_one :candidate

  def subscription_status
    translate_enum self.object, :subscription_status
  end

end