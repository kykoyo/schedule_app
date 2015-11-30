class CreateUserSuggstions < ActiveRecord::Migration
  def change
    create_table :user_suggstions do |t|
      t.integer :user_id
      t.integer :suggestion_id
      t.integer :attendance

      t.timestamps
    end
  end
end
