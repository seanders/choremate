class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :chore

  validates_presence_of :performed_at, :chore_id, :user_id
  validates :performed_at, date: true

end
