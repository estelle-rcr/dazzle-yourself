class UsersController < ApplicationController
  before_action :not_my_profile, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @attendances = Attendance.where(attendee: @user) 
    @projects = Project.where(owner: @user)
    @skill_setup_primary = SkillSetup.find_by(user: @user, primary: true)
    @skill_setup_secondary = SkillSetup.find_by(user: @user, primary: false)
  end

  def edit
    @user = User.find(params[:id])
    @attendances = Attendance.where(attendee: current_user) 
    @projects = Project.where(owner: current_user)
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


  private

def not_my_profile
  @user = User.find(params[:id])
  unless current_user == @user
    flash[:error] ="Vous n'êtes pas autorisé à consulter cette page. Voici la page publique du membre."
      redirect_to @user
  end
end

end