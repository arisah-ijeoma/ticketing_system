class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:admin)
      can :manage, :all
    elsif user.is_a? SupportAgent
      can [:read, :update, :destroy], Ticket
      can :manage, Message
    elsif user.is_a? Customer
      can :create, Ticket
      can :show, Ticket do |ticket|
        user == ticket.customer
      end
      can [:index, :update], Message do |message|
        user == message.ticket.customer
      end
    else
      can :create, Customer
    end
  end
end
