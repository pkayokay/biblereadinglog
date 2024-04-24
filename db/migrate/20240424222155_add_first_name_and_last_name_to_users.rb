class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
  end
end
