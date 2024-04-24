class AddColorThemeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :color_theme, :integer, default: 0, null: false
  end
end
