class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:admin)
      can :manage, :all
    elsif user.is_a? SupportAgent
      can [:read, :update, :destroy], Ticket
    elsif user.is_a? Customer
      can :create, Ticket
      can :read, Ticket do |ticket|
        user == ticket.customer
      end
    else
      can :create, Customer
    end
  end
end
