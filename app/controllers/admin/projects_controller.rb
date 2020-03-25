class Admin::ProjectsController < Admin::BaseController
  
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
   
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(state: params[:state])
      flash[:success] = "Les informations ont été modifiées"
      redirect_to admin_project_path
    else
      flash[:alert] = "Les informations  n'ont pas été modifiées"
      redirect_to admin_project_path
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path
    flash.alert = "Le projet #{params[:id]} a bien été supprimé !"
  end

end