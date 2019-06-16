class Candidate < ApplicationRecord

  has_one :user, as: :profile, dependent: :destroy, inverse_of: :profile
  has_many :job_subscriptions

  validates_presence_of :profession

end