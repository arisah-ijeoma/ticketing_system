class Ticket < ApplicationRecord
  belongs_to :support_agent
  belongs_to :customer
  has_many :messages, dependent: :destroy

  scope :assigned_to_me, -> agent {
    where(support_agent_id: agent.id)
  }
end
