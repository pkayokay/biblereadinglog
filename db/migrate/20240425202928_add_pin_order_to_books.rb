class AddPinOrderToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :pin_order, :integer
  end
end
