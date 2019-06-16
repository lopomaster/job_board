class CompanySerializer < ApplicationSerializer
  attributes :type, :name, :description

  has_one :user

end