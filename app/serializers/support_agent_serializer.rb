class SupportAgentSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :admin
  has_many :tickets
end
