class RenameUserSuggstionToUserSuggestion < ActiveRecord::Migration
  def change
    rename_table :user_suggstions, :user_suggestions
  end
end
