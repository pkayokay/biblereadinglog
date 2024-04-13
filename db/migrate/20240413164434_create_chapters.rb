class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters do |t|
      t.references :book, null: false, foreign_key: true, index: false
      t.integer :chapter_number, null: false
      t.datetime :completed_at, null: true

      t.timestamps
    end

    add_index :chapters, [:book_id, :chapter_number], unique: true
    add_index :chapters, :chapter_number
  end
end
