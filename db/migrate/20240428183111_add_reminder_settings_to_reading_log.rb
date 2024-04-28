class AddReminderSettingsToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :reminder_frequency, :integer, default: 1
    add_column :reading_logs, :reminder_day, :integer
    add_column :reading_logs, :reminder_time, :time
    add_column :reading_logs, :last_sent_at, :datetime

    add_index :reading_logs, :reminder_frequency
    add_index :reading_logs, :reminder_day
    add_index :reading_logs, :reminder_time
    add_index :reading_logs, :last_sent_at
  end
end
