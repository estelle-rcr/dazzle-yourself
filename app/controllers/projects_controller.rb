class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :my_project, only: [:edit, :update]
  before_action :ongoing, only: [:ongoing_project]
  
  def index
    params[:tag] ? @projects = Project.tagged_with(params[:tag]) : @projects = Project.all
    @tags = Tag.all
  end

  def show
    @project = Project.find(params[:id])
    @user_attendance = Attendance.find_by(attendee: current_user, project: @project)
    @skill_primary = SkillSetup.find_by(user: @project.owner, primary: true)
    @skill_secondary = SkillSetup.find_by(user: @project.owner, primary: false)
  end
   
  def new
    @project = Project.new
    @packages = Package.all
 
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
    @start_date = Time.new(params[:project]["start_date(1i)"],params[:project]["start_date(2i)"],params[:project]["start_date(3i)"],params[:project]["start_date(4i)"],params[:project]["start_date(5i)"])
    @project.update(start_date: @start_date)
    @packages = Package.all

    if @project.save
      flash[:success] = "Le projet a été créé !"
      redirect_to @project
    else
     flash.now[:error] = @project.errors.full_messages.to_sentence
     render :new
    end

  end

  def edit
    @packages = Package.all
    @project = Project.find(params[:id])
  end

  def update
    @packages = Package.all
    @project = Project.find(params[:id])
    @project.update(project_params)
    @start_date = Time.new(params[:project]["start_date(1i)"],params[:project]["start_date(2i)"],params[:project]["start_date(3i)"],params[:project]["start_date(4i)"],params[:project]["start_date(5i)"])
    @project.update(start_date: @start_date)

    if params[:publish] == "Soumettre mon projet"
      @project.submit_date = Time.zone.now
      @project.submit!
      if @project.save
        flash[:alert] = "Pour que le projet soit publié, le paiement doit être effectué"
        redirect_to new_project_charge_path(@project.id)
      else
       flash.now[:error] = @project.errors.full_messages.to_sentence
       render :edit
      end
    else
      if @project.save
        flash[:success] = "Le projet a été modifié !"
        redirect_to project_path(@project.id)
      else
       flash.now[:error] = @project.errors.full_messages.to_sentence
       render :edit
      end
    end
  end 


  def ongoing_project
    @project = current_user.ongoing_project[0]
    @posts = Post.where(project: @project).order("created_at DESC")
    @attendees = @project.attendees
    render layout: "layouts/ongoing_project"
  end


private

  def project_params
    params.permit(:owner_id, :package_id, :title, :short_description, :long_description, :attendees_goal, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end


  def my_project
    @project = Project.find(params[:id])
    unless current_user == @project.owner
      flash[:error] ="Vous n'êtes pas autorisé à consulter cette page"
      redirect_to root_path
    end
  end

  def ongoing
    unless user_signed_in? && (attendance(current_user) == true || ownership(current_user) == true) && current_user.ongoing_project != nil

      flash[:alert] ="Aucun projet en cours, n'hésitez pas à vous inscrire !"
      redirect_to projects_path
    end
  end

end
