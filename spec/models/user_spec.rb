require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :profile }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :username }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_confirmation_of :password }

  it { should respond_to(:email) }
  it { should respond_to(:username) }

end
