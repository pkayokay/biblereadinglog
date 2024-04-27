class AddCompletedAtToReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :completed_at, :datetime
  end
end
