class Admin::ProjectSubmissionsController < Admin::BaseController

def index


end

def show
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  if @project.state == "paid"
    @project.update(state: "published")
  end
  redirect_back(fallback_location: admin_root_path)
end

def destroy
  @project = Project.find(params[:id])
  if @project.state == "published"
    @project.update(state: "paid")
  end
  redirect_back(fallback_location: admin_root_path)
end
end
