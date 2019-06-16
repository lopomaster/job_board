class CandidateSerializer < ApplicationSerializer
  attributes :type, :profession, :notes

  has_one :user

end