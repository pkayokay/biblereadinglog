class CreateReadingLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :reading_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :is_entire_bible, null: false, default: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
