class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, length: { maximum: 20 }

  after_create :set_create_comment
  after_save :set_save_comment

  def set_create_comment
    self.comments.create(body: 'after create', user: self.user)
  end

  def set_save_comment
    comments.create(body: 'after save', user: user)
  end
end
