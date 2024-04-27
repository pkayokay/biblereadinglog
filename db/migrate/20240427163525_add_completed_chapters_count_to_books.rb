class AddCompletedChaptersCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :completed_chapters_count, :integer, null: false, default: 0
  end
end
