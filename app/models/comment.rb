class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :blog

  # Validations
  validates :content, presence: true
end
