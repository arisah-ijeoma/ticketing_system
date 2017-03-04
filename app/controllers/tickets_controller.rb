class TicketsController < ApplicationController
  load_and_authorize_resource class: 'Ticket', except: :index

  before_action :find_ticket, only: [:show, :update, :destroy]

  def index
    tickets = Ticket.all
    render json: tickets
  end

  def create
    ticket = Ticket.new(ticket_params)
    ticket.status = 'Pending'
    ticket.customer_id = @current_user.id

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

  def update
    # @ticket.update_attribute(:status, '')
  end

  def destroy
    @ticket.destroy
    head :ok
  end

  private

  def ticket_params
    params.permit(:description, :title)
  end

  def find_ticket
    @ticket = Ticket.find_by(id: params[:id])
  end
end
