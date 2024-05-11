class ChangeDefaultValueForIsEntireBible < ActiveRecord::Migration[7.1]
  def up
    change_column_default :reading_logs, :is_entire_bible, false
  end

  def down
    change_column_default :reading_logs, :is_entire_bible, true
  end
end
