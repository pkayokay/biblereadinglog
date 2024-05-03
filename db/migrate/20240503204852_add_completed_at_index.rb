class AddCompletedAtIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :reading_logs, :completed_at
    add_index :books, :completed_at
  end
end
