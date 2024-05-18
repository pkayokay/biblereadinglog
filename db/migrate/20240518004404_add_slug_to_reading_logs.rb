class AddSlugToReadingLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :slug, :string
    add_index :reading_logs, :slug, unique: true
  end
end
