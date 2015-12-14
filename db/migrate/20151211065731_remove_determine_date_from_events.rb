class RemoveDetermineDateFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :determine_date
  end
end
