class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @skills = Skill.all
    @skill_setup_primary = SkillSetup.find_by(user: current_user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: current_user, primary: false)
  end
end
