class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :approve, null: false
      t.references :user, null: false
      t.references :suggestion, null: false
      t.timestamps
    end
  end
end
