class Admin::ProjectsController < Admin::BaseController

  def index
    @projects = Project.all.order("created_at DESC")
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
   @project = Project.find(params[:id])
 end

 def update
  @project = Project.find(params[:id])

  @project.update(project_params)
  @start_date = Time.parse(params[:project].to_s)
  @project.update(start_date: @start_date)


  if @project.save
    flash[:success] = "Le projet a été modifié !"
    redirect_to admin_project_path(@project.id)
  else
   flash.now[:error] = @project.errors.full_messages.to_sentence
   render :edit
 end
end

def destroy
  @project = Project.find(params[:id])
  @project.destroy
  redirect_to admin_projects_path
  flash.alert = "Le projet #{params[:id]} a bien été supprimé !"
end

private

def project_params
  params.permit(:title, :short_description, :long_description, :attendees_goal)
end

end