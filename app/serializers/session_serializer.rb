class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :admin, :token
end
