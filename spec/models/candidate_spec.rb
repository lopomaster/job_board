require 'rails_helper'

RSpec.describe Candidate, type: :model do
  it { should have_one :user }
  it { should have_many :job_subscriptions }
  it { should have_and_belong_to_many :subscription_job_adverts }

  it { should validate_presence_of :profession }

  it { should respond_to(:profession) }
  it { should respond_to(:notes) }

end
