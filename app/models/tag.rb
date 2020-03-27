class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :projects, through: :taggings
end
