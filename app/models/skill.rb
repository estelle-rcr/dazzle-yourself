class Skill < ApplicationRecord
  has_many :skills_setups
  
  validates :title,
  presence: true,
  length: { in: 4..80}
end
