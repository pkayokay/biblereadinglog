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

Rails.application.configure do
  config.good_job.enable_cron = true
  config.good_job.cron = {
    send_questions: {
      cron: EVERY_15_MINUTES,
      class: SendRemindersJob.name,
      description: "Every 15 minutes to send reminders with past reminder_scheduled_at datetimes"
    }
  }
end
