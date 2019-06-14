class UserProfile < ApplicationRecord

  belongs_to :user

  validates_presence_of :user_id
  validates_uniqueness_of :user_id

  as_enum :user_type_cd, { candidate: 0, company: 1 }

end
