class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :skill_setups
  has_many :skills, through: :skill_setups
  has_many :attendances
  has_many :projects, through: :attendances

  has_one_attached :avatar


  # after_create :welcome_send


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def ongoing_project
    projects_as_attendee = Attendance.where(attendee: self, state: "paid").map {|a| a.project}
    projects_as_owner = Project.where(owner: self, state: "published").map {|p| project}
    projects = projects_as_attendee + projects_as_owner

    if projects.length > 0
      projects.map {|project| project.ongoing? ? project : nil }.compact
    end
  end
  

  def thumbnail
    return self.avatar.variant(resize: "200x200!")
  end

end

