class TicketSerializer < ActiveModel::Serializer
  belongs_to :customer
  belongs_to :support_agent

  attributes :id, :customer_id, :support_agent_id, :description, :title, :status
end
