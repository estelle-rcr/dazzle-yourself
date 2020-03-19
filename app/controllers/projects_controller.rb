class ProjectsController < ApplicationController
before_action :my_project, only: [:edit, :update]

  def index
<<<<<<< HEAD
    @project = Project.all
  end

  def show
    @project = Project.all
    @project = Project.find(params[:id])
=======
    @projects = Project.all
  end

  def show
    @projects = Project.find(params[:id])

>>>>>>> master
  end

  
  def new
    @packages = Package.all
  end


  def create

    @project = Project.create(project_params)
    @start_date = Time.parse(params[:project].to_s)
    @project.update(start_date: @start_date, state: "draft")

    if @project.save
      flash[:success] = "Le projet a été créé !"
      redirect_to project_path(@project.id)
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

  if params[:publish] == "Soumettre mon projet"
    @project.update(start_date: @start_date, state: "submitted", submit_date: Time.now)
    if @project.save
      flash[:alert] = "Pour que le projet soit publié, le paiement doit être effectué"
      redirect_to new_project_charge_path(@project.id)
    else
     flash.now[:error] = @project.errors.full_messages.to_sentence
     render :edit
   end
 else
  @project.update(start_date: @start_date)
  if @project.save
    flash[:success] = "Le projet a été modifié !"
    redirect_to project_path(@project.id)
  else
   flash.now[:error] = @project.errors.full_messages.to_sentence
   render :edit
 end
end



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
