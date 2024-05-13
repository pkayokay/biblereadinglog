class DefaultIsEntireBibleBack < ActiveRecord::Migration[7.1]
  def up
    change_column_default :reading_logs, :is_entire_bible, true
  end

  def down
    change_column_default :reading_logs, :is_entire_bible, false
  end
end
