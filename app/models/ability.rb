class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.superadmin_role?
       can :manage, :all
       can :access, :rails_admin       # only allow admin users to access Rails Admin
       can :dashboard
    end                 # allow access to dashboard
    if user.supervisor_role?
      can :manage, Post
      can :manage, User
      can :manage, Place
      can :access, :rails_admin
      can :dashboard
    end
    if !user.supervisor_role and !user.superadmin_role
      alias_action :create, :read, :update, :destroy, :to => :crud
      can :crud, Post
    end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
