class Project < ApplicationRecord
    belongs_to :owner, foreign_key: 'owner_id', class_name: "User"
    belongs_to :package
    has_many :attendances
    has_many :attendees, class_name: "User", through: :attendances


    validates :title,
    presence: true,
    length: { in: 3..100}

    validates :short_description,
    presence: true,
    length: { in: 5..140}

    validates :long_description,
    presence: true,
    length: { in: 200..1500}

    validates :attendees_goal,
    presence: true,
    numericality: { greater_than: 1, less_than: 6 }



  end
