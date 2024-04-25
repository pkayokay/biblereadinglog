class AddNameToReadingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :reading_logs, :name, :string, null: false, default: "Reading Log"
  end
end
