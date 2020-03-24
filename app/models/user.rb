class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :skill_setups
  has_many :skills, through: :skill_setups
  has_many :attendances
  has_many :projects 
  has_one_attached :avatar

  # after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def thumbnail
    return self.avatar.variant(resize: "200x200!")
  end

end

