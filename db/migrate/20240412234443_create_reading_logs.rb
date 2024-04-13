class CreateReadingLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_logs do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
