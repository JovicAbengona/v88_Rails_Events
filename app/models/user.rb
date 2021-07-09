class User < ApplicationRecord
    has_secure_password

    has_many :events, dependent: :destroy
    has_many :attendees, dependent: :destroy
    has_many :events_attending, through: :attendees, source: :event, dependent: :destroy
    has_many :comments, dependent: :destroy

    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

    validates :first_name, :last_name, :city, :state, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
    validates :password_digest, presence: true, confirmation: { case_sensitive: true }, length: { minimum: 8 }

    # this callback will run before saving on create and update
    before_save :downcase_email

    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    private
        def downcase_email
            self.email.downcase!
        end
end
