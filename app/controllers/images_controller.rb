class ImagesController < ApplicationController
  def new 
    @project = Project.find(params[:project_id])
  end

  def create
        @project = Project.find(params[:project_id])
        @project.image.attach(params[:image])
        redirect_to(project_path(@project))
      end
end
