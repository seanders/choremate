class AddIndexOnUsersAndSuggestions < ActiveRecord::Migration
  def change
    add_index :votes, [:user_id, :suggestion_id], unique: true
  end
end
