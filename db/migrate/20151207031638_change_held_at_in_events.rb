class ChangeHeldAtInEvents < ActiveRecord::Migration
  def change
    change_column :events, :held_at, :text
  end
end
