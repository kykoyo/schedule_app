class RenameParticipantsIdToUserId < ActiveRecord::Migration
  def change
    rename_column :events, :participants_id, :user_id
  end
end
