class JobAdvert < ApplicationRecord

  belongs_to :company
  has_many :job_subscriptions

  has_and_belongs_to_many :subscription_job_adverts, class_name: 'Candidate', join_table: :job_subscriptions

  validates_presence_of :description

end
