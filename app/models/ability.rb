class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      can :manage, Trip, :user_id => user.id
      can :manage, Lodging, :trip => { :user_id => user.id }
      can :read, :all
  end
end
