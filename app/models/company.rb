class Company < ApplicationRecord

  has_one :user, as: :profile, dependent: :destroy, inverse_of: :profile
  has_many :job_adverts

  validates_presence_of :name, :description
  validates_uniqueness_of :name

end