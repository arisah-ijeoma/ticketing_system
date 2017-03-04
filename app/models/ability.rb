class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:admin)
      can :manage, :all
    elsif user.is_a? SupportAgent
      can [:read, :update, :assign_to_self, :mine, :destroy], Ticket
      can [:read, :create, :destroy], Message
    elsif user.is_a? Customer
      can :create, Ticket
      can :show, Ticket do |ticket|
        user == ticket.customer
      end
      can :create, Message
      can :read, Message do |message|
        user == message.ticket.customer
      end
    else
      can :create, Customer
    end
  end
end
