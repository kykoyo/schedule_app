class ChangeConlumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :username
    remove_column :users, :last_name
  end
end
