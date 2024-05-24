# Preview all emails at http://localhost:3000/rails/mailers/reading_log_mailer
class ReadingLogMailerPreview < ActionMailer::Preview
  def email_reminder
    ReadingLogMailer.with(
      user: User.first,
      reading_log: User.first.reading_logs.last
    ).email_reminder
  end
end
