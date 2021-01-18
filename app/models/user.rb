class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  # validates :api_key, presence: true
  validates :api_key, uniqueness: true, presence: true
end
