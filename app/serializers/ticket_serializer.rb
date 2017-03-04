class TicketSerializer < ActiveModel::Serializer
  belongs_to :customer
  belongs_to :support_agent
  has_many :messages, dependent: :destroy

  attributes :id, :customer_id, :support_agent_id, :description, :title, :status
end
