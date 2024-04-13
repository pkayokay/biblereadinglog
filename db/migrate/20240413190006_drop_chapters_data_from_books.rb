class DropChaptersDataFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :chapters_data
  end
end
