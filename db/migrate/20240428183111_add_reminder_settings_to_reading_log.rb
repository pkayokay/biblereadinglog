class AddReminderSettingsToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :is_reminder_enabled, :boolean, default: false, null: false
    add_column :reading_logs, :reminder_frequency, :integer, default: 1, null: false
    add_column :reading_logs, :reminder_days, :string, array: true, default: ["monday"], null: false
    add_column :reading_logs, :reminder_time, :string, default: "09:00:00", null: false
    add_column :reading_logs, :last_sent_at, :datetime

    add_index :reading_logs, :is_reminder_enabled
    add_index :reading_logs, :last_sent_at
  end
end
