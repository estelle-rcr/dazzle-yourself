class Project < ApplicationRecord
  include AASM
  belongs_to :owner, foreign_key: 'owner_id', class_name: "User"
  belongs_to :package
  has_many :attendances, dependent: :destroy
  has_many :attendees, class_name: "User", through: :attendances
  has_one_attached :image
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # after_update :confirmation_email


  validates :title,
  presence: true,
  length: { in: 3..100}

  validates :short_description,
  presence: true,
  length: { in: 5..140}

  validates :attendees_goal,
  presence: true,
  numericality: { greater_than: 1, less_than: 6 }
  
  aasm column: :state do
    state :draft, initial: true
    state :submitted
    state :paid
    state :published
    state :finished

    event :submit do
      transitions from: :draft, to: :submitted
    end
    event :pay do
      transitions from: :submitted, to: :paid
    end
    event :publish do
      transitions from: :paid, to: :published
    end
    event :unpublish do
      transitions from: :published, to: :paid
    end
    event :end do
      transitions from: :published, to: :finished
    end
  end



  def ongoing?
      self.start_date <= Time.zone.now && self.end_date >= Time.zone.now
  end

  def end_date
    self.start_date + (self.package.number_of_days * 86400)
  end

  def confirmation_email
    if self.state == "paid"
      UserMailer.confirmation_charge_email(self, self.owner).deliver_now
    elsif self.state == "published" 
      UserMailer.project_published_email(self, self.owner).deliver_now
      UserMailer.reminder_participation_email(self, self.owner).deliver_later(wait_until: (self.start_date - 259200))

      self.attendees.each do |attendee|
        UserMailer.reminder_participation_email(self, attendee).deliver_later(wait_until: (self.start_date - 259200))
      end
    end
  end

  def banner
    return self.image.variant(resize: "770x433!")
  end
  
  def full?
    if self.attendees.length.to_i >= self.attendees_goal.to_i
      return true
    else
      return false
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).projects
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

end