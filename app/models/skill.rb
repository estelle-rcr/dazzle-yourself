class Skill < ApplicationRecord
  validates :title,
  presence: true,
  length: { in: 4..80}
end
