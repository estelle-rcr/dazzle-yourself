class Package < ApplicationRecord
  has_many :projects

  validates :title,
  presence: true,
  length: { in: 3..50}

  validates :price_attendee,
  presence: true,
  numericality: { greater_than: 100 }


  validates :price_owner,
  presence: true,
  numericality: { greater_than: 100 }

  validates :number_of_days,
  presence: true,
  numericality: { greater_than: 0 }
end
