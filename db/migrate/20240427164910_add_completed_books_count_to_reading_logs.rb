class AddCompletedBooksCountToReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :completed_books_count, :integer, default: 0, null: false
  end
end
