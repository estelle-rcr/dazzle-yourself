class SkillSetupsController < ApplicationController

  def new
    @skills = Skill.all
    @user = current_user
    @skill_setup_primary = SkillSetup.find_by(user: current_user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: current_user, primary: false)
  end


  def create
    @skill_setup = SkillSetup.create!(
      user: User.find(params[:user_id]),
      skill: Skill.find(params[:skill_id]),
      primary: params[:primary]
      )

    if @skill_setup.save
      flash[:success] = "Compétence actualisée !"
      redirect_to user_path(current_user.id)
    end

  end

  def update
    @skill_setup_primary = SkillSetup.find_by(user: current_user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: current_user, primary: false)

    if params[:primary] == "true"
      @skill_setup_primary.update(skill: Skill.find(params[:skill_id]))
    else
      @skill_setup_secondary.update(skill: Skill.find(params[:skill_id]))
    end

    if @skill_setup_primary.save || @skill_setup_secondary.save
      flash[:success] = "Compétence actualisée !"
      redirect_to user_path(current_user.id)

    end
  end
end