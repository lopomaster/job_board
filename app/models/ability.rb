class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?
      can :update, User do |user_element|
        user_element.id = user.id
      end

      can :read, User do
        true
      end

      can :update, JobAdvert do |job_advert|
        job_advert.user_id = user.id and user.profile_type == 'Company'
      end

      can :create, JobAdvert do |job_advert|
        user.profile_type == 'Company'
      end

      can :read, JobAdvert do
        true
      end

    end
  end
end
