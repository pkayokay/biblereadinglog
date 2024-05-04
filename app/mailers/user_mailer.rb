class UserMailer < ApplicationMailer
  def password_reset
    mail to: params[:user].email
  end

  def email_confirmation
    mail to: params[:user].email
  end
end
