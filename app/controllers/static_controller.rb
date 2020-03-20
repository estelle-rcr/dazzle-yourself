class StaticController < ApplicationController
  
   
    def home
      @projects = Project.all
    end

    def homepage
      render layout: "layouts/application_homepage"
    end


end
