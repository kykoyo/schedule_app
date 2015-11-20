class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title, :string
    add_column :events, :owner_id, :integer
    add_column :events, :participants_id, :integer
    add_column :events, :held_at, :datetime
  end
end
