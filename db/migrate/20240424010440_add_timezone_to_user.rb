class AddTimezoneToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :time_zone, :string, null: false, default: "UTC"
  end
end
