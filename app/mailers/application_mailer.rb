class ApplicationMailer < ActionMailer::Base
  default from: "Bible Reading Log <noreply@biblereadinglog.com>"
  layout "mailer"

  def skip_email?
    ENV["EMAILS_DISABLED"] == "true"
  end
end
