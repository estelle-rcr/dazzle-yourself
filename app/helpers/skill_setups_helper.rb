module SkillSetupsHelper
  def primary_skill(participant)
    SkillSetup.find_by(user: participant, primary: true).skill.title
  end
end
