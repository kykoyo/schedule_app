class RemoveHeldAtFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :held_at
  end
end
