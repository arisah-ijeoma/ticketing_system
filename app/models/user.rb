class User < ApplicationRecord
  has_secure_token
  has_secure_password

  has_many :tickets

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
