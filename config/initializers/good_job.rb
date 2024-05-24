ActiveSupport.on_load(:good_job_application_controller) do
  def is_admin_user?
    user = CurrentUserService.set_session_user(session:)
    user&.is_admin?
  end

  before_action do
    raise ActionController::RoutingError.new("Not Found") unless is_admin_user?
  end
end

EVERY_15_MINUTES = "*/15 * * * *"
EVERY_1_MINUTE = "* * * * *"
SEVEN_DAYS = 604800

Rails.application.configure do
  config.good_job.enable_cron = true
  config.good_job.cleanup_preserved_jobs_before_seconds_ago = SEVEN_DAYS
  config.good_job.cron = {
    send_questions: {
      cron: EVERY_15_MINUTES,
      class: "SendRemindersJob",
      description: "Every 15 minutes to send reminders with past reminder_scheduled_at datetimes"
    }
  }
end
