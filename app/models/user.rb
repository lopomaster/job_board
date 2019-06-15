class User < ApplicationRecord

  include Devise::Models::DatabaseAuthenticatable

  devise :database_authenticatable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy:  Devise::JWT::RevocationStrategies::Null

  has_one :user_profile

  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => Devise::email_regexp
  validates_presence_of :username, :first_name, :last_name, :email, :encrypted_password

  accepts_nested_attributes_for :user_profile, reject_if: :all_blank, allow_destroy: false

end
