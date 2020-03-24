class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :skill_setups
  has_many :skills, through: :skill_setups
  has_many :attendances
  has_many :projects, through: :attendances

  # after_create :welcome_send




  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def ongoing_project
    projects_as_attendee = Attendance.where(attendee: self, state: "paid")
    projects_as_owner = Project.where(owner: self, state: "published")
    projects = []


    if projects_as_attendee.length > 0
      projects_as_attendee.each do |attendance|
        projects << attendance.project
      end
    end

    if projects_as_owner.length > 0
      projects_as_owner.each do |project|
        projects << project
      end
    end

    ongoing_projects = []
    if projects.length > 0
      projects.each do |project|
        if project.start_date <= Time.zone.now && project.end_date >= Time.zone.now
          ongoing_projects << project
        end
      end
      return ongoing_projects[0]
    end

  end
  
end

