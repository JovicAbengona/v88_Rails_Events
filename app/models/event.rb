class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees
  has_many :comments, dependent: :destroy

  validates :name, :date, :city, :state, presence: true
  validate :date_valid_not_past

  def date_valid_not_past
    if !date.blank? and date < Date.today
      errors.add(:date, "is in invalid because it's in the past")
    end
  end
end
