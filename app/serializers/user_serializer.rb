class UserSerializer < ApplicationSerializer
  attributes :username, :first_name, :last_name, :email

  belongs_to :profile

end