class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
