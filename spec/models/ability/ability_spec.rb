require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do

  describe "Job Adverts abilities" do
    subject(:ability) { Ability.new(user) }

    context "User as company can update a job advert" do
      let(:user) { create(:user, :as_company) }

      it do
        job_advert = create :job_advert, company: user.profile
        should be_able_to(:update, job_advert)
      end

      it do
        other_user_company = create(:user, :as_company)
        job_advert = create :job_advert, company: other_user_company.profile
        should_not be_able_to(:update, job_advert)
      end
    end


    context "Only User as company can create a job advert" do
      let(:user) { create(:user, :as_company) }
      let(:job_advert) { create(:job_advert, company: user.profile) }

      it do
        should be_able_to(:create, job_advert)
      end
    end

    context "A Candidate User can not create a job advert" do
      let(:user) { create(:user, :as_candidate) }

      it do
        should_not be_able_to(:create, JobAdvert.new)
      end
    end

    context "User can read and list job adverts" do
      let(:user) { create(:user, :as_candidate) }
      let(:job_advert) { create(:job_advert) }

      it do
        should be_able_to(:list_adverts, JobAdvert)
      end

      it do
        should be_able_to(:read, job_advert)
      end
    end


    context "Company User can list adverts created" do
      let(:user) { create(:user, :as_company) }
      let(:job_advert) { create(:job_advert, company: user.profile) }

      it do
        should be_able_to(:my_adverts_as_company, JobAdvert)
      end
    end

    context "Candidate User can not list adverts created" do
      let(:user) { create(:user, :as_candidate) }
      it do
        should_not be_able_to(:my_adverts_as_company, JobAdvert)
      end
    end


    # context "Candidate User can list adverts as candidate" do
    #   let(:user) { create(:user, :as_candidate) }
    #   let(:job_advert) { create(:job_advert) }
    #
    #   it do
    #     should be_able_to(:my_adverts_as_candidate, JobAdvert)
    #   end
    # end
    #
    # context "Company User can not list adverts as candidate" do
    #   let(:user) { create(:user, :as_company) }
    #   let(:job_advert) { create(:job_advert, company: user.profile) }
    #
    #   it do
    #     should_not be_able_to(:my_adverts_as_candidate, JobAdvert)
    #   end
    # end

    # Users

    context "User as company can update a job advert" do
      let(:user) { create(:user, :as_company) }
      it do
        should be_able_to(:read, user)
      end

      it do
        should be_able_to(:update, user)
      end

      it do
        other_user_company = create(:user, :as_company)
        should_not be_able_to(:update, other_user_company)
      end
    end

  end
end

