class MessageSerializer < ActiveModel::Serializer
  belongs_to :ticket

  attributes :text, :ticket_id
end
