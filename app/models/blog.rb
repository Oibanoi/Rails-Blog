class Blog < ApplicationRecord
  # Associations
  belongs_to :author
  has_many :comments, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :content, presence: true
end
