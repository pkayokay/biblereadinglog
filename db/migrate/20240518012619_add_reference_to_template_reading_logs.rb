class AddReferenceToTemplateReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :reading_logs, :template_reading_log, foreign_key: { to_table: :reading_logs }, index: false
    add_index :reading_logs, [:template_reading_log_id, :user_id], unique: true
  end
end
