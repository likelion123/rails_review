class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, length: { maximum: 20 }

  enum status: [:draft, :publish, :canceled]
end
