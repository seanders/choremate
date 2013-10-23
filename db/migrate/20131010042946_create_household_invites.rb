class CreateHouseholdInvites < ActiveRecord::Migration
  def change
    create_table :household_invites do |t|
      t.references :household, index: true, null: false
      t.string :token, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :household_invites, [:email, :household_id], unique: true
  end
end
