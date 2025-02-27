class Author < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :blogs, dependent: :destroy
end
