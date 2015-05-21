class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all

    if user.persisted?
      #normal user
      can :manage, Map, user_id: user.id
    else
      #guest
    end
  end
end
