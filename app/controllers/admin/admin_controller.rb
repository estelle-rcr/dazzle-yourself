class Admin::AdminController < Admin::BaseController


def index
  @projects = Project.all
end

end