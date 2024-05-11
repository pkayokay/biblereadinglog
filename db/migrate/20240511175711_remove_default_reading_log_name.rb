class RemoveDefaultReadingLogName < ActiveRecord::Migration[7.1]
  def up
    change_column_default :reading_logs, :name, nil
  end

  def down
    change_column_default :reading_logs, :name, "Reading Log"
  end
end
