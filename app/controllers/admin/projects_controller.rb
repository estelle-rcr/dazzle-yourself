class Admin::ProjectsController < Admin::BaseController
  
  def index
    @projects = Project.all
  end
end