class StaticController < ApplicationController
  
   
    def home
      @projects = Project.all
    end

    def homepage
    end


end
