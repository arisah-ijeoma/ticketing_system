class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :token
  has_many :tickets
end
