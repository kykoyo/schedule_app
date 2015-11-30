class ChangeTypeOfSuggestionDate < ActiveRecord::Migration
  def change
    change_column :suggestions, :suggested_date, :text
  end
end
