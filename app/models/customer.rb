class Customer < ApplicationRecord
  has_secure_token
  has_secure_password

  has_many :tickets, dependent: :destroy
end
