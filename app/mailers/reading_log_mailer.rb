class ReadingLogMailer < ApplicationMailer
  def email_reminder
    return if skip_email?

    @user = params[:user]
    @reading_log = params[:reading_log]
    current_time = Time.now.in_time_zone(@user.time_zone).strftime("%a, %b %d")

    mail to: @user.email, subject: "Your Reminder for #{@reading_log.name.titleize} on #{current_time}"
  end
end
