class ImagesController < ApplicationController
  def create
        @project = Project.find(params[:project_id])
        @project.image.attach(params[:image])
        redirect_to(user_path(@user))
      end
end
