class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :reading_log, null: false, foreign_key: true, index: false

      t.timestamps
    end

    add_index :books, [:reading_log_id, :name], unique: true
    add_index :books, [:slug, :reading_log_id], unique: true
  end
end
