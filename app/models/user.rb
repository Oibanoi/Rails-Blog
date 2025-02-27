class User < ApplicationRecord
  has_secure_password
  # Associations
  has_one :author, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
