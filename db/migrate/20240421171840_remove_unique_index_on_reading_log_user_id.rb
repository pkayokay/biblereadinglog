class RemoveUniqueIndexOnReadingLogUserId < ActiveRecord::Migration[7.1]
  def change
    remove_index :reading_logs, :user_id, unique: true
    add_index :reading_logs, :user_id
  end
end
