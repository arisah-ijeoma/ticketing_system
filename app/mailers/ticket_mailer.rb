class TicketMailer < ApplicationMailer
  def creation(ticket)
    @ticket = ticket
    @customer = @ticket.customer
    mail(to: @customer.email, subject: "Your request has been logged with id #{ticket.id}")
  end

  def resolved(ticket)
    @ticket = ticket
    @customer = @ticket.customer
    mail(to: @customer.email, subject: "Your request with id #{ticket.id} has been resolved")
  end
end
