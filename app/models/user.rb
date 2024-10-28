class User < ApplicationRecord
  has_one_attached :photo
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :posts
end
