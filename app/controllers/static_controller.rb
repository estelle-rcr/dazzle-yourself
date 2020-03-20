class StaticController < ApplicationController
    def homepage
      render layout: "layouts/application_homepage"
      @packages = Package.all
    end

    def home
      @projects = Project.all
	    render layout: "layouts/application_home"
    end
end
