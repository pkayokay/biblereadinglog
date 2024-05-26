class AddLastBookCompletedDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :last_book_completed_details, :jsonb
  end
end
