class JobSubscription < ApplicationRecord

  belongs_to :job_advert
  belongs_to :candidate
  has_one :company, through: :job_advert

  validates_presence_of :job_advert, :candidate, :subscription_status_cd
  validates_uniqueness_of :candidate, scope: :job_advert_id

  as_enum :subscription_status, { reject: 0, highlight: 1, hire: 2, pending: 3 }

end
