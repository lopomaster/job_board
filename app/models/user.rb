class User < ApplicationRecord

  PROFILE_TYPES = [Candidate, Company]

  include Devise::Models::DatabaseAuthenticatable

  devise :database_authenticatable, :trackable, :validatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy:  Devise::JWT::RevocationStrategies::Null

  belongs_to :profile, polymorphic: true, dependent: :destroy, required: true

  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => Devise::email_regexp
  validates_presence_of :username, :first_name, :last_name, :email

  accepts_nested_attributes_for :profile, reject_if: :all_blank, allow_destroy: false

  def build_profile(params, profile_type)
    raise "Unknown profile_type: #{profile_type}" unless PROFILE_TYPES.include?(profile_type)
    self.profile = profile_type.new(params)
  end

end
