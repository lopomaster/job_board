class Candidate < ApplicationRecord

  has_one :user, as: :profile, dependent: :destroy, inverse_of: :profile
  has_many :job_subscriptions

  has_and_belongs_to_many :subscription_job_adverts, class_name: 'JobAdvert', join_table: :job_subscriptions

  validates_presence_of :profession

end