class Attendance < ApplicationRecord
  belongs_to :project
  belongs_to :attendee, foreign_key: 'attendee_id', class_name: "User"


  # after_create :confirmation_send

  def confirmation_send
    UserMailer.confirmation_participation_email(self.project, self.attendee).deliver_now
  end


end
