class Admin::ProjectSubmissionsController < Admin::BaseController

def index


end

def show
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  @project.publish!
  redirect_back(fallback_location: admin_root_path)
end

def destroy
  @project = Project.find(params[:id])
  @project.unpublish!
  redirect_back(fallback_location: admin_root_path)
end

end
