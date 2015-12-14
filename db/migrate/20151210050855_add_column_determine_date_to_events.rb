class AddColumnDetermineDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :determine_date, :integer
  end
end
