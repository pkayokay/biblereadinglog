class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :first_name, :last_name, presence: true
  normalizes :first_name, with: ->(first_name) { first_name.strip }
  normalizes :last_name, with: ->(last_name) { last_name.strip }

  has_many :reading_logs, dependent: :destroy
  has_many :books, through: :reading_logs

  enum color_theme: {
    green: 0,
    red: 1,
    blue: 2,
    gray: 3
  }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 15.minutes do
    updated_at
    # Invalidates old timestamp when user signs-in again via last_sign_in_at update
    # Invalidates old timestamp when user re-sends email confirmation when a user is touched user.touch
  end

  def has_default_time_zone?
    time_zone == "UTC"
  end

  def initials
    (first_name.first + last_name.first).upcase
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def confirmed?
    confirmed_at.present?
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  color_theme     :integer          default("green"), not null
#  confirmed_at    :datetime
#  email           :string           not null
#  first_name      :string           not null
#  is_admin        :boolean          default(FALSE), not null
#  last_name       :string           not null
#  last_sign_in_at :datetime
#  password_digest :string           not null
#  time_zone       :string           default("UTC"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
