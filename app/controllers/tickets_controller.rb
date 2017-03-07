# require 'render_anywhere'

class TicketsController < ApplicationController
  load_and_authorize_resource class: 'Ticket'

  before_action :find_ticket, only: [:show, :admin_assign, :assign_to_self, :destroy]

  def index
    tickets = if @current_user.is_a? Customer
                @current_user.tickets
              else
                Ticket.all
              end
    render json: tickets
  end

  def mine
    tickets = Ticket.assigned_to_me(@current_user)
    render json: tickets
  end

  def report
    tickets = Ticket.closed_one_month
    render json: tickets
  end

  def create
    ticket = @current_user.tickets.new(ticket_params)
    ticket.status = 'Pending'

    if ticket.save
      TicketMailer.creation(ticket).deliver_now
      render json: ticket, status: :created, serializer: TicketSerializer, root: nil
    else
      render json: { error: 'Error creating ticket' }, status: :unprocessable_entity
    end
  end

  def show
    if @ticket
      render json: @ticket, serializer: TicketSerializer
    else
      render status: 404
    end
  end

  def assign_to_self
    @ticket.update_attributes(status: 'In Review', support_agent_id: @current_user.id)
    render json: { ticket: @ticket, message: 'Assigned to you' }, status: :ok
  end

  def admin_assign
    support_agent_id = params['ticket']['support_agent_id']
    support_agent = SupportAgent.find_by(id: support_agent_id)
    @ticket.update_attributes(status: 'In Review', support_agent_id: support_agent_id)
    render json: { ticket: @ticket, message: "Assigned to #{support_agent.first_name} #{support_agent.last_name}" }, status: :ok
  end

  def resolved
    @ticket.update_attributes(status: 'Resolved')
    TicketMailer.resolved(@ticket).deliver_now
    render json: { ticket: @ticket, message: 'This ticket has been resolved' }, status: :ok
  end

  def destroy
    @ticket.destroy
    head :ok
  end

  private

  def ticket_params
    params.require(:ticket).permit(:description, :title)
  end

  def find_ticket
    @ticket = Ticket.find_by(id: params[:id])
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/report.pdf")
  end

  def filename
    "report_one_month.pdf"
  end
end
