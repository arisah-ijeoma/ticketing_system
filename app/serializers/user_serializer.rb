class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :type, :last_name, :admin
  has_many :tickets
end
