class RemoveColumnFromSuggestions < ActiveRecord::Migration
  def change
    remove_column :suggestions, :count_good
    remove_column :suggestions, :count_soso
    remove_column :suggestions, :count_bad
  end
end
