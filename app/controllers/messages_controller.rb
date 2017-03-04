class MessagesController < ApplicationController
  load_and_authorize_resource class: 'Message'

  before_action :find_ticket, only: [:index, :create]
  before_action :find_message, only: [:show, :destroy]

  def index
    if (@current_user == @ticket.customer) || (@current_user.is_a? SupportAgent)
      messages = @ticket.messages
      render json: messages
    else
      render json: { message: 'You are not unauthorized to access this page' }, status: 403
    end
  end

  def create
    message = @ticket.messages.new(message_params)

    if message.save
      if @current_user.is_a? Customer
        MessageMailer.support_agent(message).deliver_now
      else
        MessageMailer.customer(message).deliver_now
      end
      render json: message, status: :created, serializer: MessageSerializer, root: nil
    else
      render json: { error: 'Error' }, status: :unprocessable_entity
    end
  end

  def show
    if @message
      render json: @message, serializer: MessageSerializer
    else
      render status: 404
    end
  end

  def destroy
    @message.destroy
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

  def find_ticket
    @ticket = Ticket.find_by(id: params[:ticket_id])
  end

  def find_message
    ticket = Ticket.find_by(id: params[:ticket_id])
    @message = ticket.messages.find_by(id: params[:id])
  end
end
