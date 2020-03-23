class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :skill_setups
  has_many :skills, through: :skill_setups
  has_many :attendances
  has_many :projects 

  # after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  
  def is_available(project)
    attendee_projects = Attendance.where(attendee: self)
    owner_projects = Project.where(owner: self)
    project_dates = (project.start_date..project.end_date)

    unavailable_dates = []

    attendee_projects.each do |project_a|
      unavailable_dates << (project_a.start_date..project_a.end_date)
    end

    owner_projects.each do |project_b|
      unavailable_dates << (project_b.start_date..project_b.end_date)
    end


    if(project_dates & unavailable_dates).empty? 
      return true
    else
      return false
    end

  end


end

