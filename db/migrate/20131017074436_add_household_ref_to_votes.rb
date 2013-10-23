class AddHouseholdRefToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :household, index: true
  end
end
