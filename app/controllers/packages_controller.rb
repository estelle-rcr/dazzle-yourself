class PackagesController < ApplicationController
  def index
  	@packages = Package.all
  	@package = Package.find(3)

  end
end
