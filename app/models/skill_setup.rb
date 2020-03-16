class SkillSetup < ApplicationRecord
  belongs_to :user
  belongs_to :primary_skill, foreign_key: 'primary_skill_id', class_name: "Skill"
  has_one :secondary_skill, foreign_key: 'secondary_skill_id', class_name: "Skill"
end
 