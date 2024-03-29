class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :manage, Category, user: user
    can :manage, Task, category: {user: user} 
  end
end
