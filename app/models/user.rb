class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::Models::DatabaseAuthenticatable

  devise :database_authenticatable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy:  Devise::JWT::RevocationStrategies::Null

  has_one :user_profile

  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => Devise::email_regexp

  accepts_nested_attributes_for :user_profile, reject_if: :all_blank, allow_destroy: false

end
