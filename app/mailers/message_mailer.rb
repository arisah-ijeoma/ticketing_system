class MessageMailer < ApplicationMailer
  def customer(message)
    @message = message
    @ticket = message.ticket
    @customer = @ticket.customer
    mail(to: @customer.email, subject: "Re: [Ticket ID ##{@ticket.id}#] - #{@ticket.title}")
  end

  def support_agent(message)
    @message = message
    @ticket = message.ticket
    @support_agent = @ticket.support_agent
    mail(to: @support_agent.email, subject: "Re: [Ticket ID ##{@ticket.id}#] - #{@ticket.title}")
  end
end
