class User < ApplicationRecord
  has_many :posts

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_presence_of :password_confirmation, on: :create
end
