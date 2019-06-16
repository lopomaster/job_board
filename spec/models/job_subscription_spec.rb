require 'rails_helper'

RSpec.describe JobSubscription, type: :model do
  it { should belong_to :job_advert }
  it { should belong_to :candidate }
  it { should have_one :company }

  it { should validate_presence_of :job_advert }
  it { should validate_presence_of :candidate }
  it { should validate_presence_of :subscription_status_cd }

  it "validates uniqueness of candidate scoped to job_advert" do
    company = create(:user, :as_company)
    candidate = create(:user, :as_candidate)
    job_advert = create :job_advert, company: company.profile
    expect( create( :job_subscription, candidate: candidate.profile, job_advert: job_advert ) ).to be_valid
    expect( build( :job_subscription, candidate: candidate.profile, job_advert: job_advert ) ).to_not be_valid
  end

  it { should respond_to(:candidate) }
  it { should respond_to(:job_advert) }

  it { should respond_to(:subscription_status) }

end


