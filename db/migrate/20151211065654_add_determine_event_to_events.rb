class AddDetermineEventToEvents < ActiveRecord::Migration
  def change
    add_column :suggestions, :determine_event, :integer
  end
end
