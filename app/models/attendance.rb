class Attendance < ApplicationRecord
  belongs_to :project
  belongs_to :attendee, foreign_key: 'attendee_id', class_name: "User"
end
