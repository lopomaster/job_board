class JobAdvert < ApplicationRecord


  has_one :company
  validates_presence_of :description

end
