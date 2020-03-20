class StaticController < ApplicationController


  def home
    @projects = Project.all
	render layout: "layouts/application_home"
  end

  def homepage
  end
  
  def index
	@packages = Package.all
  end

end
