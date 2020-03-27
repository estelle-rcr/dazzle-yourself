class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title,
  presence: true,
  length: { in: 3..100}

  validates :content,
  presence: true,
  length: { in: 3..1500}
end
