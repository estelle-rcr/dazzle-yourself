class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user


  validates :comment,
  presence: true,
  length: { in: 1..1000}


end
