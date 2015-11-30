class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.datetime :suggested_date
      t.integer :count_good
      t.integer :count_soso
      t.integer :count_bad
      t.integer :event_id

      t.timestamps
    end
  end
end
