class AddCompletedAtToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :completed_at, :datetime
  end
end
