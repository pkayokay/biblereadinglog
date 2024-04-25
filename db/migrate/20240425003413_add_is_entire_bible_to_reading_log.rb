class AddIsEntireBibleToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :is_entire_bible, :boolean, default: true, null: false
  end
end
