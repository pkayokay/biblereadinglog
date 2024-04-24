class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email, with: ->(email) { email.strip.downcase }
  has_many :reading_logs, dependent: :destroy

  enum color_theme: {
    green: 0,
    red: 1,
    blue: 2,
    gray: 3
  }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def has_default_time_zone?
    time_zone == "UTC"
  end

  def initials
    if name.presence
      name_split = name.split(" ")
      if name_split.one?
        return name_split.first[0]
      else
        name_split.first[0] + name_split.last[0]
      end
    else
      email.slice(0..1)
    end
  end
end
