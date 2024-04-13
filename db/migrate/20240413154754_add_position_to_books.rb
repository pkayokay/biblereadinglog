class AddPositionToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :position, :integer, null: false
    add_index :books, [:position, :reading_log_id], unique: true
  end
end
