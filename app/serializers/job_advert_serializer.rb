class JobAdvertSerializer < ApplicationSerializer
  attributes :description, :id
  has_one :company
end