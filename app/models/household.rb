class Household < ActiveRecord::Base
  has_many :users, :through => :household_users
  has_many :household_users
  has_many :suggestions
  has_many :chores
  has_many :invites, class_name: 'HouseholdInvite', foreign_key: :household_id
  has_many :votes

  validates_presence_of :name
end
