class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ReadingLog.includes(:user)
      .where(completed_at: nil, is_reminder_enabled: true)
      .where("reminder_scheduled_at <= ?", Time.current)
      .find_each(batch_size: 100) do |reading_log|
      ReadingLogMailer.with(
        user: reading_log.user,
        reading_log: reading_log
      ).email_reminder.deliver_now

      set_next_reminder_scheduled_at(reading_log: reading_log)
    end
  end

  def set_next_reminder_scheduled_at(reading_log:)
    reminder_scheduled_at = CalculateReminderScheduledAtService.new(reading_log:).call
    reading_log.update!(
      last_sent_at: Time.current,
      reminder_scheduled_at: reminder_scheduled_at
    )
  end
end
