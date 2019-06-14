


class CaabdidateInterestedAdvert < ApplicationRecord

  belongs_to :company
  belongs_to :candidate

  validates_presence_of :company, :candidate
  validates_uniqueness_of :candidate, scope: :company

  as_enum :user_type_cd, { candidate: 0, company: 1 }

end
