class StaticController < ApplicationController
  def home
    @projects = Project.where(state: "published")
    
  render layout: "layouts/application_home"
  end
  def homepage
    @packages = Package.all
  end
  
end


