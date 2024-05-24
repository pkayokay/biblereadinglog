class CalculateReminderScheduledAtService
  def initialize(reading_log:)
    @reading_log = reading_log
    @user = reading_log.user
  end

  attr_accessor :reading_log, :user

  def call
    # TODO: add callback to execute calculations when timezone changes and display warning in user timezone settings UI
    return if reading_log.reminder_days.blank?

    # Determine the target date based on scheduled frequency
    target_date = case reading_log.reminder_frequency
    when "daily" then set_daily_target_date
    when "weekly" then set_weekly_target_date
    when "monthly" then set_first_monthly_target_date
    end

    reminder_scheduled_at = build_remimder_time(target_date) if target_date.present?
    reminder_scheduled_at
  end

  private

  def set_daily_target_date
    sorted_reminder_days = reading_log.reminder_days.filter_map { |day_name|
      day_number = (current_time - 1.day).next_occurring(day_name.to_sym).day
      {day_name: day_name.to_sym, day_number:, for_today: today_day_number == day_number}
    }.sort_by { |day| day[:day_number] }

    scheduled_today = sorted_reminder_days.find { |day| day[:for_today] }

    if scheduled_today
      if already_past_today?
        only_has_one_day_selected = sorted_reminder_days.length == 1
        if only_has_one_day_selected
          current_time.next_occurring(scheduled_today[:day_name])
        else
          sorted_reminder_days_without_today = sorted_reminder_days.filter_map { |a| a unless a[:for_today] }
          current_time.next_occurring(sorted_reminder_days_without_today.first[:day_name])
        end
      else
        current_time
      end
    else
      current_time.next_occurring(sorted_reminder_days[0][:day_name])
    end
  end

  def set_weekly_target_date
    if scheduled_same_day?
      already_past_today? ? next_occurrence : current_time
    else
      next_occurrence
    end
  end

  def set_first_monthly_target_date
    if scheduled_same_first_day_of_month?
      already_past_today? ? next_occurance_next_month : current_time
    elsif scheduled_in_the_future?
      first_occurrence_this_month
    elsif scheduled_in_the_past?
      next_occurance_next_month
    end
  end

  # Build the scheduled time using the target date and scheduled time from the question
  def build_remimder_time(target_date)
    hour, minutes, seconds = reading_log.reminder_time.split(":")
    ActiveSupport::TimeZone[user.time_zone].local(
      target_date.year,
      target_date.month,
      target_date.day,
      hour.to_i,
      minutes.to_i,
      seconds.to_i
    )
  end

  def current_time
    Time.current.in_time_zone(user.time_zone)
  end

  def remimder_time
    Time.parse(reading_log.reminder_time).in_time_zone(user.time_zone)
  end

  def already_past_today?
    remimder_time.to_time <= current_time.to_time
  end

  def reminder_day
    reading_log.reminder_days.first.to_sym
  end

  def scheduled_same_day?
    reminder_day == current_time.strftime("%A").downcase.to_sym
  end

  def next_occurrence
    current_time.next_occurring(reminder_day)
  end

  def first_occurrence_this_month
    (current_time.beginning_of_month - 1.day).next_occurring(reminder_day)
  end

  def first_day_number
    first_occurrence_this_month.day
  end

  def today_day_number
    current_time.day
  end

  def today_day_name
    current_time.strftime("%A").downcase
  end

  def scheduled_same_first_day_of_month?
    first_day_number == today_day_number
  end

  def scheduled_in_the_future?
    first_day_number > today_day_number
  end

  def scheduled_in_the_past?
    first_day_number < today_day_number
  end

  def next_occurance_next_month
    (current_time.next_month.beginning_of_month - 1.day).next_occurring(reminder_day)
  end
end
