class ProjectsController < ApplicationController


  def index
    @projects = Project.all
  end

  def show
    @projects = Project.find(params[:id])
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
      redirect_to projects_path
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
      flash[:danger] = "Pour que le projet soit publié, le paiement doit être effectué"
      redirect_to new_project_charge_path(@project.id)
    else
     flash.now[:error] = @project.errors.full_messages.to_sentence
     render :new
   end
 else
  @project.update(start_date: @start_date)
  if @project.save
    flash[:success] = "Le projet a été modifié !"
    redirect_to projects_path
  else
   flash.now[:error] = @project.errors.full_messages.to_sentence
   render :new
 end
end



end

private

def project_params
  params.permit(:owner_id, :package_id, :title, :short_description, :long_description, :attendees_goal)
end



end
