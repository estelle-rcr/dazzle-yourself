class Skill < ApplicationRecord
  has_many :skills_setups, dependent: :destroy
  
  validates :title,
  presence: true,
  length: { in: 4..80}
end
