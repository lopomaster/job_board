class JobAdvertSerializer < ApplicationSerializer
  attributes :description
  has_one :company
end