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

    end
  end
end
