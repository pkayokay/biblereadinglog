class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :reading_log, null: false, foreign_key: true, index: { unique: false}

      t.timestamps
    end

    add_index :books, [:name, :reading_log_id], unique: true
    add_index :books, [:slug, :reading_log_id], unique: true
  end
end
