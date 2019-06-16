require 'rails_helper'

RSpec.describe JobAdvert, type: :model do
  it { should belong_to :company }
  it { should have_many :job_subscriptions }
  it { should have_and_belong_to_many :subscription_job_adverts }
  it { should validate_presence_of :description }

  it { should respond_to(:company) }
  it { should respond_to(:description) }

end