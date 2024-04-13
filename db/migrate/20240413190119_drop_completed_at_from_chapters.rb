class DropCompletedAtFromChapters < ActiveRecord::Migration[7.1]
  def change
    remove_column :chapters, :completed_at
  end
end
