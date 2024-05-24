class AddLastReadAtToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :last_read_at, :datetime
  end
end
