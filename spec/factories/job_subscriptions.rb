FactoryBot.define do

  factory :job_subscription, class: JobSubscription do
    candidate
    job_advert
    subscription_status { :pending }
  end

end
