class StaticController < ApplicationController
  
   
    def home
      @projects = Project.all
    end

    def homepage
    end

    def index 
    end 


end
