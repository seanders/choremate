class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :point_value, null: false
      t.boolean :approved, null: false
      t.references :household, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
