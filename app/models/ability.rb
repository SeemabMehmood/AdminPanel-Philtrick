class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can [:read, :edit, :update], User, id: user.id
        cannot :index, User

        can [:read], Worker, users: { id: user.id }
        can [:index], Transaction, user: { id: user.id }
        can [:withdraw], Transaction
      end
    end
  end
end
