class ChangeSuggestionsAndEvents < ActiveRecord::Migration
  def change
    remove_column :suggestions, :determine_event_id
    add_column :events, :determine_date_id, :integer
  end
end
