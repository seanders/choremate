class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :point_value, null: false
      t.references :household, null: false

      t.timestamps
    end
  end
end
