class Admin::AdminController < Admin::BaseController


def index
  @projects = Project.all
  @projects_to_approve = Project.where(state: "paid")
end

end