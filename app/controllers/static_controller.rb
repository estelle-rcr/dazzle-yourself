class StaticController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
   
    def home
    end

    def homepage
    end

    def index 
    end 

    def secret 
    end
end
