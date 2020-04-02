module ProjectsHelper

  def attendance(project)
    if Attendance.find_by(attendee: current_user, project: project)
      return true
    end
  end

  
end
