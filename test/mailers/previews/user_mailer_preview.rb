# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def password_reset
    UserMailer.with(user: User.first, token: "12345").password_reset
  end

  def email_confirmation
    UserMailer.with(user: User.first, token: "12345").email_confirmation
  end
end
