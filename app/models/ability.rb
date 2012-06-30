class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      can :manage, :all, :user_id => user.id
      can :read, :all
  end
end
