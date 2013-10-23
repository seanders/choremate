class CreateHouseholdUsers < ActiveRecord::Migration
  def change
    create_table :household_users do |t|
      t.references :user, null: false
      t.references :household, null: false
      t.timestamps
    end

    add_index :household_users, [:user_id, :household_id], unique: true
  end
end
