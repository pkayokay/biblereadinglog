class AddReminderSettingsToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :is_reminder_enabled, :boolean, default: false
    add_column :reading_logs, :reminder_frequency, :integer, default: 1
    add_column :reading_logs, :reminder_days, :string, array: true, default: []
    add_column :reading_logs, :reminder_time, :time
    add_column :reading_logs, :last_sent_at, :datetime

    add_index :reading_logs, :is_reminder_enabled
    add_index :reading_logs, :last_sent_at
  end
end
