class Attendance < ApplicationRecord
  include AASM
  belongs_to :project
  belongs_to :attendee, foreign_key: 'attendee_id', class_name: "User"
  # after_create :confirmation_send

aasm column: :state do
  state :pending, initial: true
  state :paid
  state :cancelled

  event :pay do
    transitions from: :pending, to: :paid
  end
  event :cancel do
    transitions from: :paid, to: :cancelled
  end

end


  def confirmation_send
    UserMailer.confirmation_participation_email(self.project, self.attendee).deliver_now
    UserMailer.new_participation_email(self.project, self.project.owner, self.attendee).deliver_now
  end


end
