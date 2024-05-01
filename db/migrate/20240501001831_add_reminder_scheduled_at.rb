class AddReminderScheduledAt < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :reminder_scheduled_at, :datetime
    add_index :reading_logs, :reminder_scheduled_at
  end
end
