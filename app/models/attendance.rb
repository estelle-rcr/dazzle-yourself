class Attendance < ApplicationRecord
  belongs_to :package_id
  belongs_to :attendee, class_name: "User"
end
