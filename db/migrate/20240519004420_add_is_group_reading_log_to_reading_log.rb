class AddIsGroupReadingLogToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :is_group_reading_log, :boolean, default: false, null: false
  end
end
