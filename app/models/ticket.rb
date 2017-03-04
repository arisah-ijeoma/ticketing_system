class Ticket < ApplicationRecord
  belongs_to :support_agent
  belongs_to :customer
  has_many :messages, dependent: :destroy
end
