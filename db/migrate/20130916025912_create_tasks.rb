class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.time :performed_at, null: false
      t.references :chore, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
