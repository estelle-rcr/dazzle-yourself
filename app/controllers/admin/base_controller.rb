class Admin::BaseController < ActionController::Base
layout 'admin'
before_action :check_if_admin

  def check_if_admin
    unless user_signed_in? && current_user.is_admin == true
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end

end
