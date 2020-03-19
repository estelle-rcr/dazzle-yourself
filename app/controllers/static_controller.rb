class StaticController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
   
    def home
      @projects = Project.all
    end

    def index 
      
    end 

    def secret 

    end
end
