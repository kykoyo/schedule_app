class RenameDetermineEventInSuggestions < ActiveRecord::Migration
  def change
    rename_column :suggestions, :determine_event, :determine_event_id
  end
end
