class HouseholdUser < ActiveRecord::Base
  belongs_to :household
  belongs_to :user

  validates_presence_of :user_id, :household_id
end
