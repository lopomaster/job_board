class Candidate < ApplicationRecord

  has_one :user, as: :profile, dependent: :destroy, inverse_of: :profile

  validates_presence_of :profession

end