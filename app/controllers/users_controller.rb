class UsersController < ApplicationController
  
  def show
    @user = current_user 
    @attendances = Attendance.where(attendee: current_user) 
    @projects = Project.where(owner: current_user)
    @skills = Skill.all
    @skill_setup_primary = SkillSetup.find_by(user: current_user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: current_user, primary: false)
  end

  def edit
    @user = User.find(params[:id])
    @skills = Skill.all
    @skill_setup_primary = SkillSetup.find_by(user: current_user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: current_user, primary: false)
    
  end

  def update
    @user = User.find(params[:id])
      if @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
        flash[:success] = "Vos informations personnelles ont été modifiées"
        redirect_to @user
      else
        flash[:alert] = "Vos informations personnelles n'ont pas été modifiées"
        redirect_to @user
      end
  end

end
