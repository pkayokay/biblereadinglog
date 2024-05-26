class DropLastBookCompletedAt < ActiveRecord::Migration[7.1]
  def change
    remove_column :reading_logs, :last_book_completed_at
  end
end
