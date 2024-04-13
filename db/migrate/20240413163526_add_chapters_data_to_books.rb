class AddChaptersDataToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :chapters_data, :jsonb, null: false
    add_index :books, :chapters_data
  end
end
