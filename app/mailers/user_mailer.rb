class UserMailer < ApplicationMailer
  def password_reset
    return if skip_email?
    mail to: params[:user].email, subject: "Reset Your Password"
  end

  def email_confirmation
    return if skip_email?
    mail to: params[:user].email, subject: "Confirm Your Email Address"
  end
end
