class SupportAgentSerializer < ActiveModel::Serializer
  has_many :tickets

  attributes :id, :email, :first_name, :last_name, :admin, :token
end
