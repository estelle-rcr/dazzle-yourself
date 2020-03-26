class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :my_project, only: [:edit, :update]

  def index
    @projects = Project.all   
  end

  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @packages = Package.all
 
  end

  def create

    @user = current_user

    @project = Project.create(project_params)
    @start_date = Time.parse(params[:project].to_s)
    @project.update(start_date: @start_date)
    @packages = Package.all
    if @project.save
      flash[:success] = "Le projet a été créé !"
      redirect_to new_user_skill_setup_path(@user.id)
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
    @start_date = Time.parse(params[:project].to_s)
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
end


private



def project_params
  params.permit(:owner_id, :package_id, :title, :short_description, :long_description, :attendees_goal)
end


  def my_project
    @project = Project.find(params[:id])
    unless current_user == @project.owner
      flash[:error] ="Vous n'êtes pas autorisé à consulter cette page"
      redirect_to root_path
    end
  end

end
