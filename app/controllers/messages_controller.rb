class MessagesController < ApplicationController
  load_and_authorize_resource class: 'Message'

  before_action :find_ticket
  before_action :find_message, only: [:index, :update, :destroy]

  def index
    messages = @ticket.messages
    render json: messages
  end

  def create
    message = @ticket.messages.new(message_params)

    if message.save
      MessageMailer.creation(message).deliver_now
      render json: message, status: :created, serializer: MessageSerializer, root: nil
    else
      render json: { error: 'Error' }, status: :unprocessable_entity
    end
  end

  def update
    if @message.update_attributes(message_params)
      if @current_user.is_a? Customer
        MessageMailer.support_agent(@message).deliver_now
      else
        MessageMailer.customer(@message).deliver_now
      end
      render json: @message, status: 200, serializer: MessageSerializer, root: nil
    else
      render json: { error: 'Error' }, status: :unprocessable_entity
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
    @message = @ticket.messages.find_by(id: params[:id])
  end
end
