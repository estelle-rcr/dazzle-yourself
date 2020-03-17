class ProjectsController < ApplicationController
  def index

  end

  def new
    @packages = Package.all
  end


  def create
    @packages = Package.all
    @start_date = Time.parse(params[:start_date].to_s)
    
    @project = Project.new(
      owner: current_user,
      package_id: params[:package_id],
      title: params[:title],
      short_description: params[:short_description],
      long_description: params[:long_description],
      start_date: @start_date,
      attendees_goal: params[:attendees_goal])

    if @project.save
      flash[:success] = "Le projet a été créé !"
      redirect_to projects_path
    else
     flash.now[:error] = @project.errors.full_messages.to_sentence
     render :new
   end
 end

 private 

end
