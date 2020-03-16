class Project < ApplicationRecord
    belongs_to :owner, class_name: "User"
    belongs_to :package_id
    has_many :attendances
    has_many :attendees, foreign_key: 'attendee_id', class_name: "User", through: :attendances


    validates :title,
    presence: true,
    length: { 
      maximum: 5,
      tokenizer: lambda { |str| str.split(/\s+/) },
      too_long: "Le titre est limité à 7 mots"
    }

    validates :short_description,
    presence: true,
    length: { in: 5..140}

    validates :long_description,
    presence: true,
    length: { in: 200..1500}

    validates :attendees_goal,
    presence: true,
    numericality: { greater_than: 1 },
    numericality: { less_than: 6 }



  end
