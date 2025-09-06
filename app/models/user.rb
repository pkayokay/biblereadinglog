class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  generates_token_for :confirmation, expires_in: 15.minutes do
    updated_at
    # Invalidates old timestamp when user signs-in again or re-sends confirmation email when user is touched
  end

  def confirmed?
    confirmed_at.present?
  end
end
