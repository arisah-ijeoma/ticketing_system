class CustomerSessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :token
end