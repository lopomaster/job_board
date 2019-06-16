class JobAdvert < ApplicationRecord

  has_one :company
  has_many :job_subscriptions

  validates_presence_of :description

end
