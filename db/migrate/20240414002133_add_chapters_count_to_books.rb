class AddChaptersCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :chapters_count, :integer, null: false
  end
end
