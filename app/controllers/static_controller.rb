class StaticController < ApplicationController
  def home
    @projects = Project.all
    render layout: "layouts/application_home"
  end
  def homepage
    @packages = Package.all
  end
  
  def aboutus
  end
  
end


