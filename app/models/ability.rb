class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?
      can :update, User do |user_element|
        user_element.id == user.id
      end

      can :read, User do
        true
      end


      # Adverts

      can :update, JobAdvert do |job_advert|
        job_advert.company_id == user.id and user.profile_type == 'Company'
      end

      can :create, JobAdvert do
        user.profile_type == 'Company'
      end

      can :my_adverts_as_company, JobAdvert do
        user.profile_type == 'Company'
      end

      can :my_adverts_as_candidate, JobAdvert do
        user.profile_type == 'Candidate'
      end

      can [:list_adverts, :read], JobAdvert do
        true
      end


      #Subscriptions

      can :manage, JobSubscription do |job_subscription|
        user.profile_type == 'Company' and job_subscription.job_advert.company_id == user.id
      end

      can :create, JobSubscription do |job_subscription|
        user.profile_type == 'Candidate' and job_subscription.candidate_id = user.id
      end

      can :index, JobSubscription do |job_subscription|
        user.profile_type == 'Candidate'
      end

    end
  end
end
