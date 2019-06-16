class JobSubscription < ApplicationRecord

  belongs_to :company
  belongs_to :candidate

  validates_presence_of :company, :candidate
  validates_uniqueness_of :candidate, scope: :company

  as_enum :subscription_status, { reject: 0, highlight: 1, hire: 2 }

end
