class AddTotalBooksCountToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :books_count, :integer, null: false
  end
end
