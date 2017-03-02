class Ticket < ApplicationRecord
  belongs_to :support_agent, foreign_key: :user_id, class_name: 'SupportAgent'
  belongs_to :customer, foreign_key: :user_id, class_name: 'Customer'
  has_many :messages, dependent: :destroy
end
