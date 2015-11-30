class RenameColumnAttendanceToTagInUserSuggestions < ActiveRecord::Migration
  def change
    rename_column :user_suggestions, :attendance, :tag
  end
end
