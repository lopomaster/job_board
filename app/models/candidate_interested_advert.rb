class CandidateInterestedAdvert < ApplicationRecord

  belongs_to :company
  belongs_to :candidate

  validates_presence_of :company, :candidate
  validates_uniqueness_of :candidate, scope: :company

end
