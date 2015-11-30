class RenameSuggestedDate < ActiveRecord::Migration
  def change
    rename_column :suggestions, :suggested_date, :suggestion_date
  end
end
