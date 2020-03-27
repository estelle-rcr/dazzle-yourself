class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :skill_setups, dependent: :destroy
  has_many :skills, through: :skill_setups
  has_many :attendances, foreign_key: 'attendee_id', dependent: :destroy
  has_many :projects, through: :attendances
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar


  # after_create :welcome_send


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end


  def is_available?(project)
    attendee_projects = Attendance.where(attendee: self)
    owner_projects = Project.where(owner: self)
    project_dates = (project.start_date.strftime("%d/%m/%Y").to_datetime..project.end_date.strftime("%d/%m/%Y").to_datetime)

    unavailable_dates = []

    attendee_projects.each do |attendance|
      (attendance.project.start_date.strftime("%d/%m/%Y").to_datetime..attendance.project.end_date.strftime("%d/%m/%Y").to_datetime).each do |date|
        unavailable_dates << date
      end
    end

    owner_projects.each do |project_o|
      (project_o.start_date.strftime("%d/%m/%Y").to_datetime..project_o.end_date.strftime("%d/%m/%Y").to_datetime).each do |date|
        unavailable_dates << date
      end
    end

    if project_dates.any? {|project_date| unavailable_dates.include?(project_date) }
      return false
    else
      return true
    end

  end

  def ongoing_project

    projects_as_attendee = Attendance.where(attendee: self, state: "paid").map {|a| a.project }.compact
    projects_as_owner = Project.where(owner: self, state: "published").map {|project| project }.compact

    projects = projects_as_attendee + projects_as_owner

    if projects.length > 0
      projects.map {|project| project.ongoing? ? project : nil }.compact
    end
  end


  def thumbnail
    return self.avatar.variant(resize: "200x200!")
  end


  
end

