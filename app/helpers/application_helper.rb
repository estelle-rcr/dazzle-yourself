module ApplicationHelper

  def bootstrap_class_for_flash(type)
    case type
      when 'notice' then "alert-info"
      when 'success' then "alert-success"
      when 'error' then "alert-danger"
      when 'alert' then "alert-warning"
    end
  end

  def ownership(user)
    if Project.where(owner: user).length > 0
      return true
    end
  end

  def attendance(user)
    if Attendance.where(attendee: user).length > 0
      return true
    end
  end

end
