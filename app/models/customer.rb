class Customer < ApplicationRecord
  has_secure_token
  has_secure_password

  has_many :tickets, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            uniqueness: {case_sensitive: false}

  validates :password, length: { minimum: 6, if: :validate_password? }

  private

  def validate_password?
    password.present?
  end
end
