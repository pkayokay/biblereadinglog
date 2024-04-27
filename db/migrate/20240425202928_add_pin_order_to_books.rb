class AddPinOrderToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :pin_order, :integer
    add_index :books, [:pin_order, :reading_log_id], unique: true
  end
end
